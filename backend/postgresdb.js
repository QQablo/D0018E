const pg = require('pg');

const { Client } = pg
 
const client = new Client({
  user: 'postgres',
  password: 'postgres',
  host: 'localhost',
  port: 5333,
  database: 'D0018ECOMMERCE',
})

const conn=await client.connect();

if (conn) {
  console.log('Connected to the database');
}

exports.GenericQuery = (input) => {
    result = client.query('SELECT $1::text', [input]);
    return result;
}
