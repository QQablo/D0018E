const express = require('express');
const pool = require('../config/db');

const router = express.Router();

// TODO: ADD INPUT VALIDATION TO ALL ROUTES.

// Input: product_id and size.
router.post('/add', async(req, res) => {
    
    const client = await pool.connect();
    try{
        const insertQuery = 'INSERT INTO cart_items (cart_id, product_id, product_name, quantity, sub_total, size) ' + 
                            'SELECT $1, product_id, name, 1, price, $2 FROM products WHERE product_id=$3';
        if(!req.session.cart){ // Create a cart if one is does not exist.
            let customerId = null;
            if(req.session.user){ // If a customer is logged in, attached the cart to the account.
                customerId = req.session.user.id;
            }
            console.log("USER ID: ", customerId);
            await client.query('BEGIN'); // Start a transaction-
            // Create the cart.
            const newCart = await client.query('INSERT INTO carts (customer_id) VALUES ($1) RETURNING cart_id', [customerId]);
            
            const cartId = newCart.rows[0].cart_id;

            // Add a new item to the cart.
            await client.query(insertQuery, [cartId, req.body.size, req.body.product_id]);
            await client.query('COMMIT');
            
            // Transaction complete, add the cart id to the session cookie.
            req.session.cart = { 
                id: cartId
            }
            return res.status(200).json({message: 'Cart created and item added to it.'});
        } else { // Cart exists.
            
            const {rows} = await client.query(
                'SELECT * FROM cart_items WHERE cart_id=$1 AND product_id=$2 AND size=$3',
                [req.session.cart.id, req.body.product_id, req.body.size]
            );
            // Check if shoes of the same type and size are already in the cart.
            if (rows.length > 0){ // Increase the quantity and price.
                
                const cartItemID = rows[0].cart_item_id;
                //console.log(cartItemID);
                await client.query(
                    'UPDATE cart_items SET quantity = quantity + 1, sub_total= (quantity + 1) * p.pris ' +
                    'FROM (SELECT price AS pris FROM products WHERE product_id=$1) p ' + 
                    'WHERE cart_item_id=$2', [req.body.product_id, cartItemID]);
            } else{ // Simply add the new item to the table.
                await client.query(insertQuery, [req.session.cart.id, req.body.size, req.body.product_id]);
            } 
            await client.query('UPDATE carts SET last_updated = CURRENT_DATE WHERE cart_id = $1', [req.session.cart.id]);
            return res.status(200).json({message: 'Item added to the cart.'});
        }
    } catch (err) {
        await client.query('ROLLBACK');
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while adding a product to the cart.'});    
    } finally {
        client.release();
    }
});

// Input: product_id and size.
router.put('/decrease', async(req, res) => {
    const client = await pool.connect();
    try{
        if(req.session.cart){
            client.query('BEGIN');
            const {rows} = await client.query(
                'SELECT * FROM cart_items WHERE cart_id=$1 AND product_id=$2 AND size=$3',
                [req.session.cart.id, req.body.product_id, req.body.size]);
            if(rows.length >0){
                const cartItemId = rows[0].cart_item_id;
                if (rows[0].quantity > 1) { // Decrease the quantity.
                    await client.query(
                        'UPDATE cart_items SET quantity = quantity - 1, sub_total= (quantity - 1) * p.pris ' +
                        'FROM (SELECT price AS pris FROM products WHERE product_id=$1) p ' + 
                        'WHERE cart_item_id=$2', 
                        [req.body.product_id, cartItemId]);
                } else { // Delete the row.
                    await client.query('DELETE FROM cart_items WHERE cart_item_id = $1', [cartItemId]);
                }

                await client.query('COMMIT');
                // Delete the cart if it has no items.
                const cartIsEmpty = await client.query('SELECT * from cart_items WHERE cart_id=$1', [req.session.cart.id]);
                if(cartIsEmpty.rows.length == 0){
                    await client.query('DELETE FROM carts WHERE cart_id=$1', [req.session.cart.id]);
                    req.session.cart = null;
                    console.log("decrease: Last item removed -> Cart deleted.");
                } else {
                    await client.query('UPDATE carts SET last_updated = CURRENT_DATE WHERE cart_id = $1', [req.session.cart.id]);
                }
                return res.status(200).json({message: 'Item removed from the cart.'});
            }
        }
        return res.status(400).json({message: 'Invalid operation.'});
    } catch (err) {
        await client.query('ROLLBACK');
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while updating the cart.'});
    } finally {
        client.release();
    }
});

// Remove a product from the cart, regardless of the quantity
// Input: cart_item_id
router.delete('/delete', async (req, res) => {
    const client = await pool.connect();
    try {
        if(req.session.cart){
            await client.query('BEGIN');
            await client.query( 
                'DELETE FROM cart_items WHERE cart_item_id = $1 ' + 
                'RETURNING (SELECT COUNT(*) - 1 ' +
                'FROM cart_items ' + 
                'WHERE cart_id = $2) as cartItems', 
                [req.query.cart_item_id, req.session.cart.id]
            );

            // Delete the cart if it has no items.
            const { rows } = await client.query('SELECT * from cart_items WHERE cart_id=$1', [req.session.cart.id]);

            if(rows.length == 0){
                await client.query('DELETE FROM carts WHERE cart_id=$1', [req.session.cart.id]);
                req.session.cart = null;
                console.log("delete: Last item removed -> Cart deleted.");
            } else {
                await client.query('UPDATE carts SET last_updated = CURRENT_DATE WHERE cart_id = $1', [req.session.cart.id]);
            }
            await client.query('COMMIT');
            return res.status(200).json({message: 'Item removed from the cart.'});
        }
    } catch (error) {
        await client.query('ROLLBACK');
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while updating the cart.'});
    } finally {
        client.release();
    }
});

// Returns all of the items in the cart.
router.get('/items', async (req, res) => {
    try{
        if (req.session.cart){
            const {rows} = await pool.query(
                'SELECT  c.cart_item_id, c.product_id, c.product_name, c.quantity, c.sub_total, c.size, p.image ' +
                'FROM cart_items AS c ' +
                'INNER JOIN products p ON c.product_id = p.product_id ' +
                'WHERE cart_id=$1 ' +
                'ORDER BY c.product_name DESC', [req.session.cart.id]
            );

            if (rows.length > 0){
                console.log("Cart content returned.");
                return res.status(200).json(rows);
            } else {
                console.log("Empty cart -> Should not happen.");
                return res.status(204).json({message:"Empty cart"});
            }
        } else {
            console.log("Cart does not exist.");
            return res.status(204).json({message:"Empty cart"});
        }
    } catch (err){
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while fetching the cart.'});
    }
});


// Returns the quantity of all the items in the cart
router.get('/count', async (req, res) => {
    try{
        if(req.session.cart){
            const { rows } = await pool.query(
                'SELECT SUM(quantity) as count FROM cart_items WHERE cart_id=$1', 
                [req.session.cart.id]
            );
            res.status(200).json(rows[0]);
        } else{
            return res.status(204).json({message: 'Cart not found.'});
        }
    } catch (err) {
        console.log(err);
        return res.status(500).json({error: 'Something went wrong while fetching the cart.'});
    }
});


module.exports = router;