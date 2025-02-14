const express = require('express');
const pool = require('../config/db');

const router = express.Router();


// Input: product_id and size.
router.post('/add', async(req, res) => {
    const client = await pool.connect();
    try{
        const insertQuery = 'INSERT INTO cart_items (cart_id, product_id, product_name, quantity, sub_total, size) ' + 
                            'SELECT $1, product_id, name, 1, price, $2 FROM products WHERE product_id=$3';
        if(!req.session.cart){ // Create a cart if one is does not exist.
            const customerId = null;
            if(req.session.user){ // If a customer is logged in, attached the cart to the account.
                customerId = req.session.user.id;
            }

            await client.query('BEGIN'); // Start a transaction-
            // Create the cart.
            const newCart = await client.query('INSERT INTO carts (customer_id) VALUES ($1) RETURNING cart_id', [customerId]);
            
            const cartId = newCart.rows[0].cart_id;

            // Add a new item to the cart.
            await client.query(insertQuery, [cartId, req.body.size, req.body.product_id]);
            await client.query('COMMIT');
            
            // Transaction complete, add the cart id to the session cookie.
            req.session.cart = { 
                id: cartId,
                itemCount: 1
            }
            return res.status(200).json({message: 'Cart created and item added to it.'});
        } else { // Cart exists.
            const {rows} = await client.query(
                'SELECT * FROM cart_items WHERE cart_id=$1 AND product_id=$2 AND size=$3',
                [req.session.cart.id, req.body.product_id, req.body.size]);
            // Check if shoes of the same type and size are already in the cart.
            if (rows.length > 0){ // Increase the quantity and price.
                const cartItemID = rows[0].cart_item_id;
                //console.log(cartItemID);
                await client.query('UPDATE cart_items SET quantity = quantity + 1, sub_total= (quantity + 1) * p.pris ' +
                                    'FROM (SELECT price AS pris FROM products WHERE product_id=$1) p ' + 
                                    'WHERE cart_item_id=$2', [req.body.product_id, cartItemID]);
            } else{ // Simply add the new item to the table.
                await client.query(insertQuery, [req.session.cart.id, req.body.size, req.body.product_id]);
            }
            req.session.cart.itemCount++;
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
router.put('/delete', async(req, res) => {
    const client = await pool.connect();
    try{
        client.query('BEGIN');
        const {rows} = await client.query(
            'SELECT * FROM cart_items WHERE cart_id=$1 AND product_id=$2 AND size=$3 AND quantity > 1',
            [req.session.cart.id, req.body.product_id, req.body.size]);
        if(rows.length >0){
            const cartItemId = rows[0].cart_item_id;
            if (rows[0].quantity > 1) { // Decrease the quantity
                
                await client.query('UPDATE cart_items SET quantity = quantity - 1, sub_total= (quantity - 1) * p.pris ' +
                                        'FROM (SELECT price AS pris FROM products WHERE product_id=$1) p ' + 
                                        'WHERE cart_item_id=$2', [req.body.product_id, cartItemId]);
            } else { // Delete the row
                await client.query('DELETE FROM cart_items WHERE cart_item_id = $1', [cartItemId]);
            }

            client.query('COMMIT');
            req.session.cart.itemCount--;
            // Delete the cart if it has no items.
            if(req.session.cart.itemCount == 0){
                client.query('DELETE FROM carts WHERE cart_id=$1', [req.session.cart.id]);
            }
            return res.status(200).json({message: 'Item removed from the cart.'})
        }
        
        return res.status(400).json({message: 'Invalid operation.'})
    } catch (err) {
        client.query('ROLLBACK');
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while updating the cart.'})    
    } finally {
        client.release();
    }
});


router.get('/items', async (req, res) => {
    try{
        const {rows} = await pool.query('');
    } catch (err){
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while fetching the cart.'})  
    }
});


module.exports = router;