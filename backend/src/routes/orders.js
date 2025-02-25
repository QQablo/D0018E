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

        // Fetch the cart items to calculate the total price and amount of items. 
        const cartItems = await pool.query('SELECT * FROM cart_items WHERE cart_id = $1', [req.session.cart.id]);

        let totalPrice = 0;
        let itemCount = 0;
        for (const item of cartItems.rows) {
            console.log('TOTALPRICE: ' + totalPrice + ' SUBTOTAL: ' + item.sub_total)
            totalPrice += Number(item.sub_total);
            itemCount += item.quantity;
        }

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
            await client.query(
                'INSERT INTO order_items (order_id, product_id, quantity, sub_total, product_name, size) ' +
                'VALUES ($1, $2, $3, $4, $5, $6)',
                [orderId, item.product_id, item.quantity, item.sub_total, item.product_name, item.size]
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
        return res.status(500).json({ message: 'Failed to create order' });
    } finally {
        client.release();
    }
});


router.get('/history', async(req, res) => {
    
    const client = await pool.connect();

    try {
        if (!req.session.user) {
            console.log('Not a logged in user. GET OUT!!!')
            return res.status(401);
        }

        

        // TBD
    } catch (error) {
        
    } finally {
        client.release();
    }
});

router.get('/can_write_review', async(req, res) => {
    try {
        if (!req.session.user) {
            console.log('Not a logged in user. In can_write_review route.')
            return res.status(401);
        }

        const { rows } = await pool.query(
            'SELECT * FROM orders as o ' +
            'INNER JOIN order_items AS oi ' +
            'ON o.order_id = oi.order_id ' + 
            'WHERE o.customer_id=$1 AND oi.product_id = $2', [req.session.user.id, req.query.product_id]);

        if (rows.length > 0) {
            return res.status(200).json({ can_write_review: true });
        } else {
            return res.status(200).json({ can_write_review: false });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Error checking if user can write a review.' });
    } 
});


// Might want to update as an admin.

module.exports = router;