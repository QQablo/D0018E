const express = require('express');
const pool = require('../config/db');

const router = express.Router();


router.post('/add_to_cart', async(req, res) => {
    try{
        if(!req.session.cart){ // Create a cart if one is does not exist.
            const customerId = null;
            if(req.session.user){ // If a customer is logged in, attached the cart to the account.
                customerId = req.session.user.id;
            }
            // Create the cart.
            const {rows} = await pool.query('INSERT INTO carts (customer_id) VALUES ($1) RETURNING cart_id', [customerId]);
            req.session.cart = {
                //id: rows.data.id
            }
        }
        // https://node-postgres.com/features/transactions
        //const {rows} = await pool.query('INSERT INTO cart_items (customer_id) VALUES ($1) RETURNING cart_id', [customerId]);
        
    } catch (err) {
        console.error(err.message);
        return res.status(500).json({error: 'Something went wrong while adding a product to the cart.'})    
    }
});

router.put('/remove_from_cart', async(req, res) => {
  try{
    const {rows} = await pool.query(
  
    );
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({error: 'Something went wrong while updating the cart.'})    
  }
});
module.exports = router;