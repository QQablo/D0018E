const express = require('express');
const usersRouter = require('./users');


const router = express.Router();


router.use('/api/user', usersRouter);




module.exports = router;