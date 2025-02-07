const express = require('express');
const usersRouter = require('./users');
const productRouter = require('./products');


const router = express.Router();


router.use('/api/user', usersRouter);
router.use('/api/products', productRouter);




module.exports = router;