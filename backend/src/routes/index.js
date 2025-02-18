const express = require('express');
const usersRouter = require('./auth');
const productRouter = require('./products');
const cartsRouter = require('./carts');
const ordersRouter = require('./orders');


const router = express.Router();


router.use('/api/user', usersRouter);
router.use('/api/products', productRouter);
router.use('/api/cart', cartsRouter);
router.use('/api/orders', ordersRouter)



module.exports = router;