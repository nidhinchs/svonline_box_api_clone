var mysql = require("mysql");
let config = require("./config").config();

var pool = mysql.createPool({
  connectionLimit: 100, //important
  host: config.export_db.host,
  port: config.export_db.username,
  user: config.export_db.username,
  password: config.export_db.password,
  database: config.export_db.database,
  debug: false,
  multipleStatements: true,
  timezone: "Asia/Kolkata"
});

module.exports = pool;
