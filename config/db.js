var mysql = require('mysql');
let common = require('./common');
var config = common.config();

var pool = mysql.createPool({
    connectionLimit: 100, //important
    host: config.import_db.host,
    port:"3306",
    user: config.import_db.username,
    password: config.import_db.password,
    database: config.import_db.database,
    debug: false,
    multipleStatements: true,
    timezone: 'Asia/Kolkata',
});

module.exports = pool;
