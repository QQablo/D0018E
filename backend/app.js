<<<<<<< HEAD
import express from 'express';
import { db } from './postgresdb.js';
=======
const express = require('express');
const database = require('./postgresdb') 
>>>>>>> d35268a7bed55c0a112a1ced41b81209f1acabfb

const app = express();
database.GenericQuery("SELECT * FROM customers");
const PORT = 3000;



app.listen(PORT, (error) =>{
    if(!error){
        console.log("Server is Successfully Running, and App is listening on port "+ PORT)
    }  else 
        console.log("Error occurred, server can't start", error);
    }
);
