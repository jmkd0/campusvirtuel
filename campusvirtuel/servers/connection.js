let mysql=require('mysql');

let conn = mysql.createConnection({
    host:       'localhost',
    user:       'root',
    password:   'dakomaje00',
    database:   'tcv'
});
module.exports = conn;