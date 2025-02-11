const express = require('express');
const pool = require('../config/db');

const router = express.Router();


router.post('/create_cart', async(req, res) => {
    try{
      const {rows} = await pool.query(
    
      );
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while adding the product to the cart.'})    
    }
});


router.put('/add_to_cart', async(req, res) => {
    try{
      const {rows} = await pool.query(
    
      );
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