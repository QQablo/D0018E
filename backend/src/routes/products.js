const express = require('express');
const pool = require('../config/db');

const router = express.Router();

// Adding a Review to the Database
router.post('/add_review', async (req, res) => {
    const { product_id, stars, title, text } = req.body;
  try {
    const {rows} = await pool.query(
		'INSERT INTO reviews (customer_id, product_id, stars, title, text)' +
		'VALUES ($1, $2, $3, $4, $5) RETURNING review_id', 
		[req.session.user.id, product_id, stars, title, text]);

    if (rows.length > 0) { 
		return res.status(200).json({message:"Review added successfully."});
	
  } else {
		return res.status(404).json({error: 'Failed to add review'});
  }
  } catch (err) {
		console.error(err.message);
		return res.status(500).json({ error: 'Something went wrong while submitting the review.' });
  }
});

// Returns all reviews for a product
router.get('/product_reviews', async (req, res) => {
  const { id: product_id } = req.query;
  try {
    	const { rows } = await pool.query(
			'SELECT r.review_id, r.stars, r.title, r.text, ' + 
			'u.first_name, u.last_name ' +
			'FROM reviews r ' +
			'INNER JOIN users u ON r.customer_id = u.user_id ' +
			'WHERE r.product_id = $1', [product_id]
    );
    if (rows.length > 0) {
		return res.status(200).json({ message: "Reviews retrieved successfully", data: rows });
    } else {
		return res.status(200).json({ message: 'No reviews found for this product.', data: [] });
    }
  } catch (err) {
		console.error(err.message);
		return res.status(500).json({ error: 'Something went wrong while retrieving the reviews.' });
  }
});

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


// Returns all available sizes.
router.get('/sizes', async (req, res) => {
	try {
		const { rows } = await pool.query('SELECT * FROM sizes');
		if (rows.length > 0) {
			return res.status(200).json(rows);
		} else {
			return res.status(404).json({ error: 'sizes not found.' });
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
		const {rows} = await pool.query('SELECT name, category_id FROM categories');
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
router.post('/create', async(req, res) => {
	console.log(req.body)
	const client = await pool.connect();
	try{
		const { name, price, description, image, sizes, categories } = req.body;
		//console.log(req.body);
		if(!name || !price || !description || !image || !sizes || !categories){
			return res.status(400).json("Invalid input.")
		}
		// 1. Add the generic fields of a product.
		const newProduct = await client.query(
			'INSERT INTO products (name, price, description, image)' + 
			'VALUES ($1, $2, $3, $4) RETURNING product_id', 
			[name, price, description, image]); 
			
		const productId = newProduct.rows[0].product_id;
		console.log("Product id: ", productId)
		// 2. Add the respective sizes.
        for (const item of sizes) {
			//console.log(item)
            await client.query(
                'INSERT INTO product_sizes (product_id, size_id, stock) ' +
                'VALUES ($1, $2, $3)',
                [productId, item.size, item.stock]
            );
        }
		
		// 3. Add the respective categories.
        for (const item of categories) {
			//console.log(item);
            await client.query(
                'INSERT INTO product_categories (product_id, category_id) ' +
                'VALUES ($1, $2)',
                [productId, item]
            );
        }
		console.log("Hello")
		client.query('COMMIT');
		return res.status(200).json({message: 'Product created successfully.'})
	} catch (err) {
			client.query('ROLLBACK');
			console.error(err.message);
			return res.status(500).json({error: 'Something went wrong while creating the product.'});
	} finally {
			client.release();
	}
});

router.delete('/delete', async (req, res) => {
    const client = await pool.connect();
    try {
        const productId = req.query.id;
        
        await client.query('BEGIN');
        
        const productExists = await client.query(
            'SELECT * FROM products WHERE product_id = $1',
            [productId]
        );
        
        if (productExists.rowCount === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        // Delete related records
        await client.query(
            'DELETE FROM product_sizes WHERE product_id = $1',
            [productId]
        );
        
        await client.query(
            'DELETE FROM product_categories WHERE product_id = $1',
            [productId]
        );

        await client.query(
            'DELETE FROM products WHERE product_id = $1',
            [productId]
        );

        await client.query('COMMIT');
        return res.status(200).json({ message: 'Product deleted successfully' });
    } catch (err) {
        await client.query('ROLLBACK');
        console.error(err.message);
        return res.status(500).json({ error: 'Error while deleting the product' });
    } finally {
        client.release();
    }
});

// update product
router.put('/update', async (req, res) => {
    const client = await pool.connect();
    try {
        const { productId, name, price, description, image, sizes, categories } = req.body;

        if (!productId || !name || !price || !description || !image || !sizes || !categories) {
            return res.status(400).json("All fields are required");
        }

        await client.query('BEGIN');

        const productExists = await client.query(
            'SELECT * FROM products WHERE product_id = $1',
            [productId]
        );
        
        if (productExists.rowCount === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        

        await client.query('COMMIT');
        return res.status(200).json({ message: 'Product updated successfully' });

    } catch (err) {
        await client.query('ROLLBACK');
        console.error(err.message);
        return res.status(500).json({ error: 'Failed to update product' });
    } finally {
        client.release();
    }
});

module.exports = router;