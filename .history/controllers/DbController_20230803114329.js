const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");
let config = require("../config/config").config();
// Include the dependency we need.
const { exec } = require("child_process");
const { request } = require("http");
const async = require("async");

exports.update_video_data = function (req, res) {};

exports.update_course = function (req, res) {
  let request = req.query;

  check_connection(function (connected) {
    if (connected == 1) {
      admin_common.select_first(
        "select * from box_update_status where box_id = " + request.box_id,
        function (callback1) {
          if (callback1.code == SUCCESS) {
            updateAllData(
              1,
              callback1.result.last_updated_log_id,
              request.course_id,
              request.box_id,
              function (call2) {
                res.json(call2);
              }
            );
          } else if (callback1.code == ERROR_EMPTY) {
            updateAllData(
              0,
              0,
              request.course_id,
              request.box_id,
              function (call3) {
                res.json(call3);
              }
            );
          } else {
            res.json(callback1);
          }
        }
      );
    } else {
      showInternetError(res);
    }
  });
};

async function updateAllData(
  isFirstTime,
  last_updated_log_id,
  course_id,
  box_id,
  callback
) {
  admin_common.selectAll(
    "select * from trigger_log where course_id = " +
      course_id +
      " and log_id > " +
      last_updated_log_id,
    async function (call1) {
      if (call1.code == SUCCESS) {
        let response = {};

        async.eachSeries(call1.result, (item, next) => {
          console.log(
            "log_id----========================----->    " + item.log_id
          );
          doAction(item, function (call2) {
            console.log("Do Action Result ------------->  " + call2);
            response = call2;
            console.log(response);
            if (call2.code == SUCCESS) {
              storeUpdatedId(box_id, item.log_id);
            } else {
              console.log(call2.status);
              i = call1.result.length;
              // callback(call2);
            }
            if (item == call1.result[call1.result.length - 1]) {
              console.log("--------------last ")
              callback(response);
              return;
            } else {
              next();
            }
          });
        });

        // for (let i = 0; i < call1.result.length; i++) {
        //   let item = call1.result[i];

        //   console.log(
        //     "log_id----========================----->    " + item.log_id
        //   );
        //   await doAction(item, function (call2) {
        //     console.log("Do Action Result ------------->  " + call2);
        //     response = call2;
        //     console.log(response);
        //     if (call2.code == SUCCESS) {
        //       storeUpdatedId(box_id, item.log_id);
        //     } else {
        //       console.log(call2.status);
        //       i = call1.result.length;
        //       // callback(call2);
        //     }
        //     // if (i == call1.result.length) {
        //     //   callback(response);
        //     //   return;
        //     // }
        //   });
        // }
        // callback(response);

        // callback(call1);
      } else {
        callback(call1);
      }
    }
  );
}

function storeUpdatedId(box_id, log_id) {
  let obj = {
    box_id: box_id,
    last_updated_log_id: log_id
  };

  admin_common.select_first(
    "select status_id from box_update_status where box_id = " + box_id,
    function (call1) {
      console.log(call1.code);
      if (call1.code == SUCCESS) {
        admin_common.update(
          obj,
          "status_id",
          call1.result.status_id,
          "box_update_status",
          function (call) {
            console.log(call.code);
          }
        );
      } else {
        admin_common.insert(obj, "box_update_status", function (call) {
          console.log(call.code);
        });
      }
    }
  );
}

async function doAction(item, callback) {
  console.log("========go into DoAction ======================");
  if (item.action == "insert") {
    console.log("insert");
    insert_data(item, function (call1) {
      callback(call1);
    });
  } else if (item.action == "update") {
    console.log("update");
    update_data(item, function (call2) {
      console.log("update data ------------->" + call2.code);

      callback(call2);
    });
  } else if (item.action == "delete") {
    console.log("delete");
    delete_data(item, function (call3) {
      callback(call3);
    });
  } else {
    callback();
  }
}

function delete_data(item, callback) {
  const fs = require("fs");
  if (item.table_name == "video") {
    common.select_first(
      "select video_path from video where video_id = " + item.primary_key_id,
      function (call2) {
        if (call2.code == SUCCESS) {
          fs.unlink(call2.result.video_path, function (err, result) {
            if (err) {
              console.log("error in deleting file ..........");
            } else {
              common.delete(
                item.primary_key_name,
                item.primary_key_id,
                item.table_name,
                function (call1) {
                  callback(call1);
                }
              );
            }
            next(err, list);
          });
        } else {
          callback(errorJsonObject);
        }
      }
    );
  } else if (item.table_name == "note") {
    common.select_first(
      "select note_path from note where note_id = " + item.primary_key_id,
      function (call2) {
        fs.unlink(call2.result.video_path, function (err, result) {
          next(err, list);
          if (err) {
            console.log("error in deleting file ..........");
          } else {
            common.delete(
              item.primary_key_name,
              item.primary_key_id,
              item.table_name,
              function (call1) {
                callback(call1);
              }
            );
          }
        });
      }
    );
  }
}

const downloadFile = (url, callback) => {
  return new Promise((resolve, reject) => {
    const https = require("https");
    let downloadFolderPath = "./public/video/";
    console.log("url------------------>");
    console.log(url);

    const splitUrl = url.split("/");
    const filename = splitUrl[splitUrl.length - 1];
    const foldername = splitUrl[splitUrl.length - 2];
    const outputPath = `${downloadFolderPath}${foldername}/${filename}`;

    console.log(outputPath);

    const file = fs.createWriteStream(outputPath);

    if (!fs.existsSync(`${downloadFolderPath}${foldername}`)) {
      fs.mkdirSync(`${downloadFolderPath}${foldername}`, {
        recursive: true
      });
    }

    https.get(url, (res) => {
      if (res.statusCode === 200) {
        console.log("get success");
        res.pipe(file).on("close", resolve);
        callback(res.statusCode);
      } else {
        reject(res.statusCode);
        callback(res.statusCode);
        console.log("get error" + res.statusCode);
      }
    });
  });
};

function insert_data(item, callback) {
  let query =
    "select * from " +
    item.table_name +
    " where " +
    item.primary_key_name +
    " = " +
    item.primary_key_id;

  admin_common.select_first(query, function (call1) {
    if (call1.code == SUCCESS) {
      if (item.table_name == "video" || item.table_name == "note") {
        downloadFile(call1.result.video_path, function (callback1) {
          console.log(call1.result);
          if (callback1 == 200) {
            common.insert(call1.result, item.table_name, function (call2) {
              console.log(call2.status);
              callback(call2);
            });
          } else {
            callback({
              code: 400,
              status: "error",
              error: "Error in downloading the File"
            });
          }
        });
      } else {
        common.insert(call1.result, item.table_name, function (call2) {
          console.log(call2.status);
          callback(call2);
        });
      }
    } else {
      callback(errorJsonObject);
    }
  });
}

function update_data(item, callback) {
  let query =
    "select * from " +
    item.table_name +
    " where " +
    item.primary_key_name +
    " = " +
    item.primary_key_id;

  admin_common.select_first(query, function (call1) {
    if (call1.code == SUCCESS) {
      if (item.table_name == "video" || item.table_name == "note") {
        fs.unlink(call1.result.video_path, function (err, result) {
          if (err) {
            console.log("error in deleting file ..........");
          } else {
            downloadFile(call1.result.video_path, function (callback1) {
              if (callback1 == 200) {
                common.update(
                  call1.result,
                  item.primary_key_name,
                  item.primary_key_id,
                  item.table_name,
                  function (call2) {
                    console.log(call2.status);
                    callback(call2);
                  }
                );
              } else {
                callback({
                  code: 400,
                  status: "error",
                  error: "Error in downloading the File"
                });
              }
            });
          }
          // next(err, list);
        });
      } else {
        common.update(
          call1.result,
          item.primary_key_name,
          item.primary_key_id,
          item.table_name,
          function (call2) {
            console.log(call2.status);
            callback(call2);
          }
        );
      }
    } else {
      callback(errorJsonObject);
    }
  });
}

function errorJsonObject() {
  return {
    code: 400,
    status: "error",
    error: "Can not fetch data"
  };
}

function showInternetError(res) {
  res.json({
    code: 400,
    status: "error",
    error: "Internet connection is not available."
  });
}

exports.ping = function (req, res) {
  let request = req.query;
  check_connection(function (connected) {
    if (connected == 1) {
      admin_common.select_first(
        "select * from box where box_id = " + request.box_id,
        function (call1) {
          if (call1.code == SUCCESS) {
            let obj = {
              box_id: request.box_id,
              created_by: request.box_id,
              created_date: getCurrentDateTime()
            };
            admin_common.insert(obj, "box_health", function (callback) {
              res.json(callback);
            });
          } else {
            res.json({
              code: 400,
              status: "error",
              error:
                "There are no box available in the admin with id = " +
                request.box_id
            });
          }
        }
      );
    } else {
      res.json({
        code: 400,
        status: "error",
        error: "Internet connection is not available."
      });
    }
  });
};

exports.get_box_updates = function (req, res) {
  admin_common.selectAll("select * from v_box_health", function (callback) {
    res.json(callback);
  });
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
          item.ip_address
        ])
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
        error: "SOME ERROR OCCURED"
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
    code: SUCCESS
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
        code: SUCCESS
      });
    } else {
      call({
        code: ERROR
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
        code: SUCCESS
      });
    } else {
      call({
        code: ERROR
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
