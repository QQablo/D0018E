require('dotenv').config();
const {Pool} = require('pg');

const pool = new Pool({
  user: "user",
  host: "localhost",
  password: 'student',
  port: 5430,
  database: 'd0018e',
  max: 10, // Maximum number of connections in the pool
  idleTimeoutMillis: 30000, // Close inactive connections after 30 seconds
});

module.exports = pool;
