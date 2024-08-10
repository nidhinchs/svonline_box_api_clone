var mysql = require("mysql");
let config = require("./config").config();

var pool = mysql.createPool({
  connectionLimit: 100, //important
  host: config.import_db.host,
  port: config.import_db.op,
  user: config.import_db.username,
  password: config.import_db.password,
  database: config.import_db.database,
  debug: false,
  multipleStatements: true,
  timezone: "Asia/Kolkata"
});

module.exports = pool;
