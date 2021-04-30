const fs = require('fs');

let common = require('./common');

let moment = require("moment-timezone");
const ERROR = "400"
const ERROR_EMPTY = "500"
const SUCCESS = "200"

function getCurrentDateTime() {
    return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}


function padLeadingZeros(num, size) {
    var s = num + "";
    while (s.length < size) s = "0" + s;
    return s;
}


exports.update_admin_data = function (req, res) {
    let config = require('../config/config').config();
    // Include the dependency we need.
    const {exec} = require('child_process');


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

        if (callback.code === SUCCESS) {
            deleteAll(callback.result, function (callback1) {
                console.log(callback1);
                let q = "SELECT CONCAT('DROP VIEW IF EXISTS `', table_schema, '`.`', table_name, '`;') as drop_query FROM information_schema.views WHERE table_schema = 'lms'";
                common.selectAll(q,function (call2) {
                    if (callback.code === SUCCESS) {
                        deleteAll(call2.result, function (callback2) {
                            console.log(callback2);
                            call(callback1);
                        });
                    }else if (callback.code == ERROR_EMPTY) {
                        call({
                            code: SUCCESS
                        });
                    }else{
                        call({
                            code: ERROR
                        });
                    }
                });

            });

        } else if (callback.code == ERROR_EMPTY) {
            call({
                code: SUCCESS
            });
        }
        else{
            call({
                code: ERROR
            });
        }
    });


}

async function replace(string,callback){
    const replacer = new RegExp("utf8mb4_0900_ai_ci", 'g')
    const replacer1 = new RegExp("ALGORITHM=UNDEFINED", 'g')
    const replacer2 = new RegExp("DEFINER=`nidhi`@`localhost` SQL SECURITY DEFINER", 'g')
    const searchRegExp = "utf8mb4_0900_ai_ci";
    const replaceWith = "utf8mb4_general_ci";

    let result = await string.replace(replacer, replaceWith);
    console.log(result);
    let result2 = await result.replace(replacer1,"");
    let result3 = await result2.replace(replacer2,"");
    //result =await string.replace(replacer1, "");
    callback(result3);
}

async function import_db(filepath, callback1) {
    const {exec} = require('child_process');
    let config = require('../config/config').config();

     let dataArr = fs.readFileSync(filepath, {encoding: "UTF-8"});

     replace(dataArr,function (callback) {
         dataArr = callback.split(";\n");

         for(let query of dataArr) {
             common.execute_query(query, function (callback) {
                 console.log(callback);

             });
         }
         callback1(callback);
     });





    /*****************************************************************************/

   /* exec(`mysql  --defaults-extra-file=.import.cnf  -u${config.import_db.username} -h${config.import_db.host} -f ${config.import_db.database} < ${config.dumpFile}`, (err, stdout, stderr) => {
        if (err) {
            console.error(`exec error: ${err}`);
            callback1({code: ERROR});
            return;
        } else {
            console.log("done");
            callback1({code: SUCCESS});
        }


    });*/

}


