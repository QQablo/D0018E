const express = require('express');
const pool = require('../config/db');

const router = express.Router();


// Returns all the sizes for a product
router.get('/product_sizes', async (req, res) => {
  try {
    const { rows } = await pool.query(
        'SELECT s.size_id, s.size ' +
        'FROM sizes s ' + 
        'INNER JOIN product_sizes ps ON s.size_id = ps.size_id ' + 
        'WHERE ps.product_id = $1', [req.query.product_id]);
    if (rows.length > 0) {
      return res.status(200).json({ message: "Sizes retrieved successfully", data: rows });
    } else {
      return res.status(404).json({ error: 'sizes not found for this product.' });
    }
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({ error: 'Something went wrong while retrieving the sizes.' });
  }
});


// Returns all the items in the products table.
router.get('/products', async(req, res) => {
    try{
      const {rows} = await pool.query(
          'SELECT  p.product_id, p.name, p.price, p.description, p.image ' +
              'FROM products p');
      //console.log(rows)
      if (rows.length > 0) { 
            console.log(req.session);
            return res.status(200).json({message:"Products retrieved successfully.", data: rows});
      } else {
            return res.status(404).json({error: 'Products not found.'});
      }
    } catch (err) {
        console.error(err.message);    
        return res.status(500).json({error: 'Something went wrong while retrieving the products.'});
    }
  });

// Return the id and name for all the categories.
router.get('/categories', async(req, res) => {
    try{
      const {rows} = await pool.query(
          'SELECT name, category_id FROM categories');
      //console.log(rows)
      if (rows.length > 0) { 
          return res.status(200).json(rows);
      } else {
          return res.status(404).json({error: 'Products not found.'});
      }
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while retrieving the products based on the category.'});
    }
  });

// Input: category_id
// Output: items the respective category. 
router.get('/category_products', async(req, res) => {
  try{
    const {rows} = await pool.query(
        'SELECT  p.product_id, p.name, p.price, p.description, p.image ' +
            'FROM products p ' +
            'INNER JOIN product_categories pc ON p.product_id=pc.product_id ' +
            'INNER JOIN categories c ON pc.category_id = c.category_id ' + 
            'WHERE c.category_id=$1', [req.query.category_id]);
    //console.log(rows)
    if (rows.length > 0) { 
        console.log("Products retrieved successfully.");
        return res.status(200).json(rows);
    } else {
        return res.status(404).json({error: 'Products not found.'});
    }
  } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while retrieving the products based on the category.'});
  }
});

// Input: the product "id"
// Ouput: the product respective data
router.get('/product', async(req, res) => {
    try{
      const {rows} = await pool.query(
            'SELECT  p.product_id, p.name, p.price, p.description, p.image '+
            'FROM products p WHERE p.product_id=$1', [req.query.id]);
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




// -------------------------ADMINISTRATIVE functionalities ------------------------> Admin auth not implemented, yet.
router.delete('/delete_product', async(req, res) => {
    try{
      const {rows} = await pool.query(
          'DELETE FROM products WHERE product_id=$1', [req.query.id]); 
      if (rows.length > 0) { 
          return res.status(200).json({message:"Product deleted successfully."});
      } else {
          return res.status(404).json({error: 'Product not found, invalid id.'});
      }
    } catch (err) {
      console.error(err.message);
      return res.status(500).json({error: 'Something went wrong while deleting the product.'});
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
    return res.status(500).json({error: 'Something went wrong while creating the product.'});
  }
});

// update product
// set product category
// set product size

module.exports = router;