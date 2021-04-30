var mysql = require('mysql');

var con = mysql.createConnection({
    host: "34.93.170.232",
    user: "root",
    password: "summ2020"
});

con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
});