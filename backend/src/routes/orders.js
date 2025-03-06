const express = require('express');
const pool = require('../config/db');

const router = express.Router();

// TODO: ADD INPUT VALIDATION TO ALL ROUTES.
router.post('/create', async (req, res) => {
    const client = await pool.connect();
    try{
        // Check if the cart exists.
        if (!req.session.cart) {
            return res.status(400).json({error: 'Cart is empty.'});
        }

        // Input validation
        const { firstName, lastName, email, phone, shippingAddress } = req.body;
        if (!firstName || !lastName || !email || !shippingAddress || !phone ) { 
            return res.status(400).json({ error: 'All fields must be provided.' });
        }

        await client.query('BEGIN');

        // Fetch the cart items with respective size information. 
        const cartItems = await pool.query(
            'SELECT ci.*, ps.stock ' +
            'FROM cart_items AS ci ' +
            'JOIN product_sizes AS ps ON ci.product_id = ps.product_id ' +
            'JOIN sizes AS s on ps.size_id = s.size_id ' + 
            'WHERE ci.cart_id = $1 AND s.size = ci.size', 
            [req.session.cart.id]);
        
        // Check for each item if there is enough in the stock.
        for (const item of cartItems.rows) {
            if (item.stock < item.quantity) {
                throw new  Error(`Not enought items in stock for ${item.product_name} with size ${item.size}. Remaining in stock: ${item.stock}`);
            }
        }
        
        let totalPrice = 0;
        let itemCount = 0;
        for (const item of cartItems.rows) {
            console.log('CURRENT TOTALPRICE: ' + totalPrice + ' SUBTOTAL: ' + item.sub_total)
            totalPrice += Number(item.sub_total);
            itemCount += item.quantity;
        }
        console.log('TOTAL PRICE AFTER CALCULATIONS: ', totalPrice)
        // The id 0 is the mockup value for anonymous users.
        let customerId = req.session.user ? req.session.user.id : 0;
        console.log("customer id: ", customerId);
        
        // Create a new order and return its id to generate the order_items table.
        const newOrder = await client.query(
            'INSERT INTO orders (first_name, last_name, email, customer_id, price, shipping_address, phone, item_count) ' +
            'VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING order_id', 
            [firstName, lastName, email, customerId, totalPrice, shippingAddress, phone, itemCount]
        ); 
        
        const orderId = newOrder.rows[0].order_id;

        // Create order items.
        for (const item of cartItems.rows) {
            // Might update with just a insert + select combo instead of multiple inserts, if time allows it.
            console.log(item)
            await client.query(
                'INSERT INTO order_items (order_id, product_id, quantity, sub_total, product_name, size) ' +
                'VALUES ($1, $2, $3, $4, $5, $6)',
                [orderId, item.product_id, item.quantity, item.sub_total, item.product_name, item.size]
            );
            
            // Update the stock for each product. 
            await client.query(
                'UPDATE product_sizes ' +
                'SET stock = stock - $1 FROM sizes AS s ' + 
                'WHERE product_sizes.product_id = $2 ' +
                'AND s.size_id = product_sizes.size_id ' +
                'AND s.size = $3 RETURNING product_sizes.stock',
                [item.quantity, item.product_id, item.size]
            );
        }
  
        // Clear and delete cart.
        await client.query('DELETE FROM cart_items WHERE cart_id = $1', [req.session.cart.id]);
        await client.query('DELETE FROM carts WHERE cart_id = $1', [req.session.cart.id]);
        await client.query('COMMIT');

        req.session.cart = null;
        return res.status(201).json({ message: 'Order created successfully', orderId });
    } catch (error) {
        await client.query('ROLLBACK');
        console.error(error);
        return res.status(500).json({ message: 'Failed to create order', errMessage: error.message });
    } finally {
        client.release();
    }
});

// Returns all the oder items related to orders for a logged in user
router.get('/history', async (req, res) => {
    try {
        if (!req.session.user) {
            return res.status(401).json({ error: 'Not a logged in user!!!!' });
        }
  
        const { rows } = await pool.query(
            'SELECT o.order_id, o.price, o.date, o.current_status, oi.product_name, oi.quantity, oi.sub_total, oi.size ' +
            'FROM orders AS o ' +
            'INNER JOIN order_items AS oi ON o.order_id = oi.order_id ' +
            'WHERE o.customer_id = $1 ', [req.session.user.id]);

        if (rows.length > 0) {
            return res.status(200).json({ message: "Orders retrieved successfully", data: rows });
        } else {
            return res.status(200).json({ message: 'No orders found.', data: [] });
        }
    } catch (err) {
        console.error(err.message);
        return res.status(500).json({ error: 'Something went wrong while retrieving order history.' });
    }
});

router.get('/order_status', async (req, res) => {
    try {
        if (!req.session.user) {
            return res.status(401).json({ error: 'Not a logged in user!!!!' });
        }
  
        const { rows } = await pool.query(
            'SELECT o.*, oi.order_item_id, oi.product_name, oi.quantity, oi.sub_total, oi.size ' +
            'FROM orders AS o ' +
            'INNER JOIN order_items AS oi ON o.order_id = oi.order_id ' +
            'WHERE o.current_status = $1 ', [req.query.status]);

        if (rows.length > 0) {
            return res.status(200).json({ message: "Orders retrieved successfully", data: rows });
        } else {
            return res.status(200).json({ message: 'No orders found.', data: [] });
        }
    } catch (err) {
        console.error(err.message);
        return res.status(500).json({ error: 'Something went wrong while retrieving the orders with status ' + req.query.status });
    }
});

router.get('/status', async (req, res) => {
    try {
        if (!req.session.user) {
            return res.status(401).json({ error: 'Not a logged in user!!!!' });
        }
        const { rows } = await pool.query('SELECT unnest(enum_range(NULL::status))::text as statuses');
        if (rows.length > 0) {
            return res.status(200).json({ message: "Order statuses retrieved successfully", data: rows });
        } 
        throw new Error('Status enum not found');
    } catch (err) {
        console.error(err.message);
        return res.status(500).json({ error: 'Something went wrong while retrieving the orders with status ' + req.query.status });
    }
});

router.put('/update_status', async (req, res) => {
    try {
        const { orderId, newStatus } = req.body;
        await pool.query(
            'UPDATE orders SET current_status = $1 WHERE order_id = $2',
            [newStatus, orderId]
        );
        res.status(200).json({ message: 'Order status updated successfully' });
    } catch (err) {
        console.error(err.message);
        res.status(500).json({ error: 'Error updating order status' });
    }
});

// Restrict to -> has already written a comment and the product has been delivered
router.get('/can_write_review', async(req, res) => {
    try {
        if (!req.session.user) {
            console.log('Not a logged in user. In can_write_review route.');
            return res.status(204).json({ error: 'Not a logged in user.' });
        }

        // Check if the customer has any delivered order with the product being viewed.
        const { rows } = await pool.query(
            `SELECT oi.order_item_id 
            FROM orders AS o
            INNER JOIN order_items AS oi ON o.order_id=oi.order_id
            WHERE o.customer_id = $1 
            AND o.current_status = $2
            AND oi.product_id = $3
            AND oi.has_comment = false`, 
            [req.session.user.id, 'Delivered', req.query.product_id]
        );
        console.log(rows);

        if (rows.length > 0) {
            return res.status(200).json({ can_write_review: true, data:rows });
        } else {
            return res.status(204).json({ can_write_review: false });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Error checking if user can write a review.' });
    } 
});


module.exports = router;
