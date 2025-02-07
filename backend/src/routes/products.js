const express = require('express');
const pool = require('../config/db');

const router = express.Router();


router.get('/products', async(req, res) => {
    try{
      const {rows} = await pool.query(
          'SELECT  p.product_id, p.name, p.price, p.description, p.image ' +
              'FROM products p');
      //console.log(rows)
      if (rows.length > 0) { 
          return res.status(200).json({message:"Products retrieved successfully.", data: rows});
      } else {
          return res.status(404).json({error: 'Products not found.'})
      }
    } catch (err) {
      console.error(err.message);
    }
  });

router.get('/category_products', async(req, res) => {
  try{
    const {rows} = await pool.query(
        'SELECT  p.product_id, p.name, p.price, p.description, p.image ' +
            'FROM products p ' +
            'INNER JOIN product_categories pc ON p.product_id=pc.product_id ' +
            'INNER JOIN categories c ON pc.category_id = c.category_id ' + 
            'WHERE c.name=$1', [req.query.category]);
    //console.log(rows)
    if (rows.length > 0) { 
        return res.status(200).json({message:"Products retrieved successfully.", data:rows});
    } else {
        return res.status(404).json({error: 'Products not found.'})
    }
  } catch (err) {
    console.error(err.message);
  }
});


router.get('/product', async(req, res) => {
    try{
      const {rows} = await pool.query(
          'SELECT  p.product_id, p.name, p.price, p.description, p.image '+
              'FROM products p ' +
              'WHERE p.product_id=$1', [req.query.id]);
      //console.log(rows)
      if (rows.length > 0) { 
          return res.status(200).json({message:"Product retrieved successfully.", data: rows});
      } else {
          return res.status(404).json({error: 'Product not found.'})
      }
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while retrieving the product.'})
    }
});




module.exports = router;