const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");
let config = require("../config/config").config();
// Include the dependency we need.
const { exec } = require("child_process");

exports.update_video_data = function (req, res) {};

exports.ping = function (req, res) {
  let request = req.query;
  check_connection(function (connected) {
    if (connected == 1) {
      let obj = {
        box_id: request.box_id,
        created_by: request.box_id,
        created_date: getCurrentDateTime(),
      };
      admin_common.insert(obj, "box_health", function (callback) {
        res.json(callback);
      });
    } else {
      res.json({ code: 400, status: "Internet connection is not available." });
    }
  });
};

exports.get_box_updates = function (req, res) {

  admin_common.selectAll("select max(created_date),box_id")
};

function check_connection(callback) {
  let connected = 0;
  require("dns").resolve("www.google.com", function (err) {
    if (err) {
      connected = 0;
      console.log("No connection");
      callback(connected);
    } else {
      connected = 1;
      console.log("Connected");
      callback(connected);
    }
  });
}

exports.update_subject_data = function (req, res) {
  let created_date = req.query.created_date;

  check_connection(function (connected) {
    if (connected == 1) {
      let query =
        "select * from subject where created_date <'" +
        created_date +
        "' and modified_date >'" +
        created_date +
        "'";

      admin_common.selectAll(query, function (callback) {
        if (callback.code == SUCCESS) {
          //there is data to update so first update it and then insert the new data.
          common.updateMultiple(
            "subject",
            callback.result,
            "subject_id",
            function (callback) {
              // res.json(callback);
              insert_subject_data(created_date, function (callback1) {
                res.json(callback1);
              });
            }
          );
        } else {
          //there is no data to update so directly insert new data.
          insert_subject_data(created_date, function (callback1) {
            res.json(callback1);
          });
        }
      });
    } else {
      res.json({ code: 400, status: "Internet connection is not available." });
    }
  });
};

function insert_subject_data(created_date, callback) {
  let query2 =
    "select * from subject where created_date >'" + created_date + "'";
  admin_common.selectAll(query2, function (callback2) {
    if (callback2.code == SUCCESS) {
      var table_fields =
        "(subject_id,course_id,subject_name,subject_desc," +
        "note_name,note_url,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) ";

      let items = callback2.result;

      var object_array = [
        items.map((item) => [
          item.subject_id,
          item.course_id,
          item.subject_name,
          item.subject_desc,
          item.note_name,
          item.note_url,
          item.is_delete,
          item.is_active,
          item.created_by,
          item.created_date,
          item.modified_by,
          item.modified_date,
          item.ip_address,
        ]),
      ];

      var table = "subject";

      common.insert_multiple_rows(
        table_fields,
        object_array,
        table,
        function (callback1) {
          callback(callback1);
        }
      );
    } else {
      callback({ code: 600, status: "Already up to date" });
    }
  });
}

exports.updateDatabase = function (req, res) {
  delete_db(function (call) {
    if (call.code == SUCCESS) {
      console.log(
        `Starting exporting data from the ${config.export_db.database} database`
      );

      // Execute a MySQL Dump and redirect the output to the file in dumpFile variable.
      /*exec(`mysqldump -u${exportFrom.user} -p${exportFrom.password} -h${exportFrom.host} --compact ${exportFrom.database} > ${dumpFile}`, (err, stdout, stderr) => {
                if (err) { console.error(`exec error: ${err}`); return; }*/

      //not require pwd :
      exec(
        `mysqldump --defaults-extra-file=.my.cnf -u${config.export_db.username} -h${config.export_db.host} --compact ${config.export_db.database} > ${config.dumpFile}`,
        (err, stdout, stderr) => {
          if (err) {
            console.error(`exec error: ${err}`);
            return;
          }
          console.log(
            `Now, importing data to the ${config.import_db.database} database`
          );
          import_db(config.dumpFile, function (callback) {
            res.json(callback);
          });
        }
      );
    } else {
      console.log("error");
      res.json({
        code: ERROR,
        error: "SOME ERROR OCCURED",
      });
    }
  });
};

async function deleteAll(result, callback) {
  for await (query of result) {
    common.execute_query(query.drop_query, function (call) {
      //callback(call);
    });
  }

  callback({
    code: SUCCESS,
  });
}

function deleteAllTables(call) {
  let q =
    "SELECT CONCAT('DROP TABLE IF EXISTS `', table_schema, '`.`', table_name, '`;') as drop_query" +
    "  FROM   information_schema.tables" +
    "  WHERE  table_schema = 'lms'";

  common.selectAll(q, function (callback) {
    console.log(callback);

    if (callback.code === SUCCESS) {
      deleteAll(callback.result, function (callback1) {
        console.log(callback1);
        call(callback1);
      });
    } else if (callback.code == ERROR_EMPTY) {
      call({
        code: SUCCESS,
      });
    } else {
      call({
        code: ERROR,
      });
    }
  });
}

function deleteAllViews(call) {
  let q =
    "SELECT CONCAT('DROP VIEW IF EXISTS `', table_schema, '`.`', table_name, '`;') as drop_query FROM information_schema.views WHERE table_schema = 'lms'";
  common.selectAll(q, function (call2) {
    console.log("***********************************");
    console.log(call2);
    console.log("**************************************");
    if (call2.code === SUCCESS) {
      deleteAll(call2.result, function (callback2) {
        console.log(callback2);
        call(callback2);
      });
    } else if (call2.code == ERROR_EMPTY) {
      call({
        code: SUCCESS,
      });
    } else {
      call({
        code: ERROR,
      });
    }
  });
}

async function delete_db(call) {
  deleteAllTables(function (call1) {
    if (call1.code == SUCCESS) {
      deleteAllViews(function (call2) {
        call(call2);
      });
    } else {
      call(call1);
    }
  });
}

async function replace(string, callback) {
  const replacer = new RegExp("utf8mb4_0900_ai_ci", "g");
  const replacer1 = new RegExp("ALGORITHM=UNDEFINED", "g");
  const replacer2 = new RegExp(
    "DEFINER=`nidhi`@`localhost` SQL SECURITY DEFINER",
    "g"
  );
  const searchRegExp = "utf8mb4_0900_ai_ci";
  const replaceWith = "utf8mb4_general_ci";

  let result = await string.replace(replacer, replaceWith);
  console.log(result);
  let result2 = await result.replace(replacer1, "");
  let result3 = await result2.replace(replacer2, "");
  //result =await string.replace(replacer1, "");
  callback(result3);
}

async function import_db(filepath, callback1) {
  let dataArr = fs.readFileSync(filepath, { encoding: "UTF-8" });

  replace(dataArr, function (callback) {
    dataArr = callback.split(";\n");

    for (let query of dataArr) {
      common.execute_query(query, function (callback) {
        console.log(callback);
      });
    }
    callback1({ code: SUCCESS });
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
