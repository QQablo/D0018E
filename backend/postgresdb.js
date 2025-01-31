const pg = require('pg');

const { Client } = pg
 
const client = new Client({
  user: 'postgres',
  password: 'password12345',
  host: 'localhost',
  port: 5334,
  database: 'database-name',
})

await client.connect();

exports.GenericQuery = (input) => {
    result = client.query('SELECT $1::text', [input]);
    return result;
}
