const express = require('express');
const session = require('express-session')
const routes = require('./routes');
const pool = require('./config/db');

const app = express();

app.use(express.json()); // Parse JSON bodies from api requests 

app.use(session({
  secret: 'your-secret-key',
  // Don't save empty sessions in the session store, i.e., when users don't do anything on the site
  saveUninitialized: false ,
  // Don't save the session if it hasn't been modified
  resave: false,
  cookie: { 
    maxAge: 60000 * 60,
    
  }
}));


// Routes
app.use(routes);



const PORT = process.env.SERVER_PORT || 3000;
app.listen(PORT, (error) =>{
    if(!error){
        console.log("Server is Successfully Running, and App is listening on port "+ PORT)
    }  else 
        console.log("Error occurred, server can't start", error);
    }
);
