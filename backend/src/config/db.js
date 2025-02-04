require('dotenv').config();
const {Pool} = require('pg');
// 

const pool = new Pool({ 
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST,
  password: process.env.POSTGRES_PASSWORD,
  port: process.env.POSTGRES_PORT,
  database: process.env.POSTGRES_DB,
  max: 10, // Maximum number of connections in the pool
  idleTimeoutMillis: 30000, // Close inactive connections after 30 seconds
});

module.exports = pool;
