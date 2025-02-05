const express = require('express');
const pool = require('../config/db');
const bcrypt = require('bcrypt');

const router = express.Router();

router.post('/customer_sign_up', async(req, res) => {
    try{
        const { first_name, last_name, email, address, phone, password } = req.body;
        
        if (!first_name || !last_name || !email || !address || !phone || !password) { // Check if all fields are provided.
            return res.status(400).json({ error: 'All fields must be provided.' });
        } else if (password.length < 8) { // Verify password length.
            return res.status(400).json({ error: 'Password must be at least 8 characters.' });
        } else{
            const {rows} = await pool.query('SELECT * FROM users WHERE email=$1', [email]);
            //console.log(rows)
            if (rows.length > 0) { // Email taken.
                return res.status(400).json({message: 'Email already in use.' });
            } else{ // Basic validation completed -> Hash the password and register the user.
                const hashedPassword = await bcrypt.hash(password, 10);
                console.log(hashedPassword)
                const result = await pool.query(
                    'INSERT INTO users (first_name, last_name, email, address, phone, passwrd, user_role) ' +
                    'VALUES ($1, $2, $3, $4, $5, $6, $7)', 
                    [first_name, last_name, email, address, phone, hashedPassword, 'customer']
                )
                if (result.rowCount === 0) { // Something went wrong with the insert.
                    return res.status(500).json({error: 'Something went wrong while creating the customer account.'})
                }
                
                //console.log(result)
                return res.status(200).json({message:"Customer registered sucessfully."});
            }
        }
    } catch (err){
        console.log(err)
        return res.status(500).json({error: 'Something went wrong while creating the customer account.'})
    }
});


// Återstår att fixa session och vagn grejer
router.post('/sign_in', async(req, res) => {
    try {
        const {email, password} = req.body;

        if (!email || !password) { 
            return res.status(400).json({ error: 'All fields must be provided.' });
        } else {
            const {rows} = await pool.query('SELECT * FROM users WHERE email=$1', [email]);

            if (rows.length === 0) { 
                return res.status(400).json({error: 'Email not found.'});
            } else {
                const user = rows[0];
                const isPasswordValid = await bcrypt.compare(password, user.passwrd);

                if (!isPasswordValid) { 
                    return res.status(400).json({error: 'Password is invalid.'});
                } else {
                    return res.status(200).json({message: 'User logged in successfully.'});
                }
            }
        }
    } catch (err) {
        console.log(err)
        return res.status(500).json({error: 'Something went wrong while signing in.'})
    }
});

module.exports = router;