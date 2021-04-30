const fs = require('fs');
const sqlite3 = require('sqlite3').verbose();


let common = require('./common');

let moment = require("moment-timezone");

function getCurrentDateTime() {
    return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}


function padLeadingZeros(num, size) {
    var s = num + "";
    while (s.length < size) s = "0" + s;
    return s;
}

/*exports.update_admin_data= function(req, res) {
    const spawn = require('child_process').spawn
    let exportFrom = {
        host: "localhost",
        user: "root",
        password: "",
        database: "demo"
    }
    let importTo = {
        host: "localhost",
        user: "root",
        password: "",
        database: "lms"
    }
    const fileName = `test.sql`;
    const wstream = fs.createWriteStream(`${fileName}`);
    console.log('---------------------')
    console.log('Running Database Backup Cron Job')
    const mysqldump = spawn('mysqldump', [ '-u', exportFrom.user, `-p${exportFrom.password}`,exportFrom.database]);

    mysqldump
        .stdout
        .pipe(wstream)
        .on('finish', () => {
            console.log('DB Backup Completed!')
        })
        .on('error', (err) => {
            console.log(err)
        })

}*/

exports.update_admin_data = function (req, res) {
    var config = common.config();
    // Include the dependency we need.
    const {exec} = require('child_process');
    //let config = require('../config/config.js');


// Where would the file be located?


    delete_db(function (call) {
        if (call.code == SUCCESS) {
            console.log(`Starting exporting data from the ${config.export_db.database} database`);

// Execute a MySQL Dump and redirect the output to the file in dumpFile variable.
            /*exec(`mysqldump -u${exportFrom.user} -p${exportFrom.password} -h${exportFrom.host} --compact ${exportFrom.database} > ${dumpFile}`, (err, stdout, stderr) => {
                if (err) { console.error(`exec error: ${err}`); return; }*/

            //not require pwd :
            exec(`mysqldump --defaults-extra-file=.my.cnf -u${config.export_db.username} -h${config.export_db.host} --compact ${config.export_db.database} > ${config.dumpFile}`, (err, stdout, stderr) => {
                if (err) {
                    console.error(`exec error: ${err}`);
                    return;
                }
                console.log(`Now, importing data to the ${config.import_db.database} database`);
                import_db(config.dumpFile, function (callback) {
                    res.json(callback);
                });

            });
        } else {
            console.log("error");
            res.json({
                code: ERROR,
                error: "SOME ERROR OCCURED"
            })
        }
    });


}

async function deleteAll(result, callback) {
    for await(query of result) {
        common.execute_query(query.drop_query, function (call) {
            //callback(call);
        });
    }
    callback({
        code: SUCCESS
    });
}

async function delete_db(call) {

    let q = "SELECT CONCAT('DROP TABLE IF EXISTS `', table_schema, '`.`', table_name, '`;') as drop_query" +
        "  FROM   information_schema.tables" +
        "  WHERE  table_schema = 'lms'"

    common.selectAll(q, function (callback) {
        console.log(callback);
        if (callback.code == SUCCESS) {
            deleteAll(callback.result, function (callback1) {
                console.log(callback1);
                call(callback1);
            });

        }
    });
    /* const {exec} = require('child_process');

     let importTo = {
         host: "localhost",
         user: "root",
         password: "",
         database: "lms"
     }

     exec(`mysqldump --defaults-extra-file=.my.cnf --add-drop-table --no-data -u${importTo.user} -h${importTo.host} --compact ${importTo.database}  > ./drop_tables.sql`, (err, stdout, stderr) => {
         if (err) {
             console.error(`exec error: ${err}`);
             return;
         }
         let query = fs.readFileSync('./drop_tables.sql', {encoding: "UTF-8"});
         common.execute_query(query, function (callback) {
             console.log(callback);
             call(callback);
         });

         console.log(`Now, importing data to the ${importTo.database} database`);
         import_db(dumpFile);

     });*/

    // console.log(query);


}

async function import_db(filepath, callback1) {

    let dataArr = fs.readFileSync(filepath, {encoding: "UTF-8"}).split(";\n");

    for await(let query of dataArr) {
        common.execute_query(query, function (callback) {
            console.log(callback);
            callback1(callback);
        });
    }
}

/*

exports.update_admin_data = async function (req, res) {
// Read the SQL file
    const dataSql = fs.readFileSync('./demo.sql').toString();
    let dataArr = fs.readFileSync('./demo.sql', {encoding: "UTF-8"}).split(";\n");

    for await(let query of dataArr) {
        common.execute_query(query, function (callback) {
            console.log(callback);
        });
    }


    /!* // Setup the database connection

     let db = new sqlite3.Database('lms', (err) => {
         if (err) {
             return console.error(err.message);
         }
         console.log('Connected to the in-memory SQlite database.');


     });

     // Convert the SQL string to array so that you can run them one at a time.
 // You can split the strings using the query delimiter i.e. `;` in // my case I used `);`
 // because some data in the queries had `;`.

     //const dataArr = dataSql.toString().split(');');
     // console.log(dataArr);

     // db.serialize ensures that your queries are one after the other depending on which one came first in your `dataArr`

     db.serialize(() => {
         // db.run runs your SQL query against the DB
         console.log('PRAGMA foreign_keys=OFF;');
         db.run('PRAGMA foreign_keys=OFF;');
         db.run('BEGIN TRANSACTION;');
         // Loop through the `dataArr` and db.run each query
         dataArr.forEach((query, index) => {
             if (query) {
                 console.log("index : " + index);
                 console.log(query);
                 // Add the delimiter back to each query before you run them
                 // In my case the it was `);`
                 query += ');';
                 db.run(query, (err) => {
                     if (err) throw err;
                 });
             }
         });
         db.run('COMMIT;');
     });
 // Close the DB connection

     db.close((err) => {
         if (err) {
             return console.error(err.message);
         }
         console.log('Closed the database connection.');
     });*!/


}
*/


