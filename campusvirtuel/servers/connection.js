const { Pool, Client } = require('pg');
const conn_prod= new Pool({
  user: 'iehz3514_komlan',
  host: 'localhost',
  database: 'iehz3514_enovsky_data_prod',
  password: 'Dakomaje00/',
  port: 5432,
})
const conn= new Pool({
    user: 'komlan',
    host: 'localhost',
    database: 'inovsky_data',
    password: 'dakomaje00',
    port: 5432,
  })


conn.connect()
module.exports = conn;