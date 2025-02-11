const express = require('express');
const pool = require('../config/db');

const router = express.Router();


router.get('/products', async(res) => {
    try{
      const {rows} = await pool.query(
          'SELECT  p.product_id, p.name, p.price, p.description, p.image ' +
              'FROM products p');
      //console.log(rows)
      if (rows.length > 0) { 
          return res.status(200).json({message:"Products retrieved successfully.", data: rows});
      } else {
          return res.status(404).json({error: 'Products not found.'});
      }
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while retrieving the products.'})
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
        return res.status(404).json({error: 'Products not found.'});
    }
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({error: 'Something went wrong while retrieving the products based on the category.'})
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
          return res.status(404).json({error: 'Product not found.'});
      }
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while retrieving the product.'});
    }
});




// ADMINISTRATIVE functionalities -> Admin auth not implemented, yet.
router.delete('/delete_product', async(req, res) => {
    try{
      const {rows} = await pool.query(
          'DELETE FROM products WHERE product_id=$1', [req.query.id]); 
      if (rows.length > 0) { 
          return res.status(200).json({message:"Product deleted successfully."});
      } else {
          return res.status(404).json({error: 'Product not found, invalid id.'})
      }
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while deleting the product.'})
    }
});

 
router.post('/create_product', async(req, res) => {
  const { name, price, description, image } = req.body
  try{
    const {rows} = await pool.query(
        'INSERT INTO products (name, price, description, image)' + 
        'VALUES ($1, $2, $3, $4) RETURNING product_id', [name, price, description, image]); 
    //console.log(rows);
    if (rows.length > 0) { 
        return res.status(200).json({message:"Product created successfully."});
    } else {
        return res.status(404).json({error: 'Successful operation, but the product id was not returned.'})
    }
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({error: 'Something went wrong while creating the product.'})
  }
});

// update product
  // set product category


module.exports = router;