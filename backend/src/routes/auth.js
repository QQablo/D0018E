const express = require('express');
const pool = require('../config/db');
const bcrypt = require('bcrypt');

const router = express.Router();

router.post('/sign_up', async(req, res) => {
    try{
        const { firstName, lastName, email, address, phone, password } = req.body;
        if (!firstName || !lastName || !email || !address || !phone || !password) { // Check if all fields are provided.
            return res.status(400).json({ error: 'All fields must be provided.' });
        } else if (password.length < 8) { // Verify password length.
            return res.status(400).json({ error: 'Password must be at least 8 characters.' });
        } else{
            const {rows} = await pool.query('SELECT * FROM users WHERE email=$1', [email]);
            //console.log(rows)
            if (rows.length > 0) { // Email taken.
                return res.status(400).json({error: 'Email already in use.' });
            } else{ // Basic validation completed -> Hash the password and register the user.
                const hashedPassword = await bcrypt.hash(password, 10);
                //console.log(hashedPassword)
                const result = await pool.query(
                    // Parameterized queries prevent sql injections.
                    'INSERT INTO users (first_name, last_name, email, address, phone, passwrd, user_role) ' +
                    'VALUES ($1, $2, $3, $4, $5, $6, $7)', 
                    [firstName, lastName, email, address, phone, hashedPassword, 'customer']
                );
                //console.log(result) 
                if (result.rowCount > 0) { 
                    return res.status(201).json({message: 'Account created successfully.'});
                } else{
                    //console.log(result);
                    return res.status(500).json({error: 'Something went wrong while creating the customer account.'});
                }
                
            }
        }
    } catch (err){
        console.log(err)
        return res.status(500).json({error: 'Something went wrong while creating the customer account.'})
    }
});


// NEED UPDATE FOR CART AND SESSIONS
router.post('/login', async(req, res) => {
    try {
        const {email, password} = req.body;

        if (!email || !password) { 
            return res.status(400).json({ error: 'All fields must be provided.' });
        } else {
            const {rows} = await pool.query('SELECT user_id, email, user_role, passwrd FROM users WHERE email=$1', [email]);
            //console.log(rows);
            
            if (rows.length === 0) { 
                
                return res.status(400).json({error: 'Email not found.'});
            } else {
                const user = rows[0];
                const isPasswordValid = await bcrypt.compare(password, user.passwrd);

                if (!isPasswordValid) { 
                    return res.status(400).json({error: 'Password is invalid.'});
                } else {
                    req.session.user = {
                                id: user.user_id, 
                                email: user.email, 
                                role: user.user_role
                            };

                    // if cart is not empty
                    // use customer id to check if it has a cart already in the database, 
                    // if not, connect the anonymous one to logged in user 
                    // else delete it and load the one stored in the db
                    return res.status(200).json({message: 'User signed in successfully.'});
                }
            }
        }
    } catch (err) {
        console.log(err)
        return res.status(500).json({error: 'Something went wrong while signing in.'})
    }
});


router.get('/logout', async (req, res) => {
    req.session.destroy();
    console.log("Session destroyed.")
});

module.exports = router;