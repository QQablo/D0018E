const express = require('express');
const pool = require('./config/db');


const app = express();

app.use(express.json()); // Parse JSON bodies from api requests 

const PORT = process.env.SERVER_PORT || 3000;

// Test
app.get('/', async(req, res) => {
  try{
    const {rows} = await pool.query('SELECT * FROM product');
    res.json(rows);
  } catch (err) {
    console.error(err.message);
  }
});

app.listen(PORT, (error) =>{
    if(!error){
        console.log("Server is Successfully Running, and App is listening on port "+ PORT)
    }  else 
        console.log("Error occurred, server can't start", error);
    }
);
