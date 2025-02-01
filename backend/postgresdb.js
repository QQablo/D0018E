import pg from 'pg';

const { Client } = pg
 
const client = new Client({
  user: 'postgres',
  password: 'password12345',
  host: 'localhost',
  port: 5334,
  database: 'database-name',
})

await client.connect();

function GenericQuery(input) {
    result = client.query('SELECT $1::text', [input]);
    return result;
}

//Viktigt: den här kastar en error eftersom filen inte är kopplad till en riktig databas än
export { GenericQuery as db};
