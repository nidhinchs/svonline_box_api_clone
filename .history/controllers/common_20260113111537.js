let connection = require("../config/db");
global.ERROR = "400";
global.SUCCESS = "200";
global.ERROR_EMPTY = "500";
const log = require("./log");
var mysql = require("mysql");

let moment = require("moment-timezone");

global.getCurrentDateTime = function () {
  return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
};

exports.insert = function (object, table, callback) {
  //todo example of object
  /*let site_obj = {
        site_name: site.site_name,
        address: (site.address == undefined) ? null : site.address,
        point: (site.point == undefined) ? null : site.point
    };*/
  // console.log(site);
  let query = "INSERT INTO " + table + " SET ?";
  connection.query(
    "INSERT INTO " + table + " SET ?",
    object,
    function (error, results, fields) {
      console.log(query);
      if (error) {
        callback({ status: "fail", code: ERROR, error: error.message });
        console.log(callback);
      } else {
        callback({
          status: "success",
          code: SUCCESS,
          cust_id: results.insertId
        });
        console.log(callback);
      }
    }
  );
};

exports.update = function (object, unique_id_name, unique_id, table, callback) {
  //todo example of object
  /*let site_obj = {
        site_name: site.site_name,
        address: (site.address == undefined) ? null : site.address,
        point: (site.point == undefined) ? null : site.point
    };*/
  // console.log(site);
  let query = "UPDATE " + table + " SET ? WHERE " + unique_id_name + " =?";
  connection.query(
    query,
    [object, unique_id],
    function (error, results, fields) {
      console.log(query);
      if (error) {
        callback({ status: "fail", code: ERROR, error: error.message });
        console.log(callback);
      } else {
        callback({ status: "success", code: SUCCESS });
        console.log(callback);
      }
    }
  );
};

exports.delete = function (unique_id_name, unique_id, table, callback) {
  //todo example of object
  /*let site_obj = {
        site_name: site.site_name,
        address: (site.address == undefined) ? null : site.address,
        point: (site.point == undefined) ? null : site.point
    };*/
  // console.log(site);
  let query = "DELETE FROM " + table + " WHERE " + unique_id_name + " =?";
  connection.query(query, [unique_id], function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({ status: "success", code: SUCCESS });
      console.log(callback);
    }
  });
};
exports.delete_direct = function (query, callback) {
  //todo example of object
  /*let site_obj = {
        site_name: site.site_name,
        address: (site.address == undefined) ? null : site.address,
        point: (site.point == undefined) ? null : site.point
    };*/
  // console.log(site);

  connection.query(query, function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({ status: "success", code: SUCCESS });
      console.log(callback);
    }
  });
};

exports.select_first = function (query, callback) {
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      console.log(error);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      if (results.length == 0) {
        callback({ status: "fail", code: ERROR_EMPTY, error: "No Data Found" });
      } else {
        callback({ status: "success", code: SUCCESS, result: results[0] });
      }
    }
  });
};

exports.selectAll = function (query, callback) {
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      if (results.length == 0) {
        callback({ status: "fail", code: ERROR_EMPTY, error: "No Data Found" });
      } else {
        callback({ status: "success", code: SUCCESS, result: results });
      }
    }
  });
};

exports.updateMultiple = function (
  table,
  values,
  unique_column_name,
  callback
) {
  console.log(values);
  let queries = "";
  values.forEach(function (item) {
    Object.keys(item);

    queries += "UPDATE " + table + " set ";
    let keys = Object.keys(item);
    keys.forEach(function (key, i) {
      console.log(key);

      if (key == unique_column_name) {
        if (i == keys.length - 1) {
          queries +=
            " where " +
            unique_column_name +
            " = " +
            item[unique_column_name] +
            ";";
        }
      } else {
        queries += key + " = '" + item[key] + "'";
        if (i == keys.length - 1) {
          queries +=
            " where " +
            unique_column_name +
            " = " +
            item[unique_column_name] +
            ";";
        } else {
          queries += " and ";
        }
      }
    });

    // queries += mysql.format("UPDATE tabletest SET users = ? WHERE id = ?; ", item);
  });
  console.log(queries);
  connection.query(queries, (error, results, fields) => {
    // console.log(queries);
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      callback({ status: "success", code: SUCCESS });
    }
  });
  // let query1 = "UPDATE "+table + " set "
  // connection.query(query,
  //     (error, results, fields) => {
  //         console.log(query);
  //         if (error) {
  //             console.log(error.message);
  //             callback({"status": "fail", "code": ERROR, "error": error.message});
  //         } else {
  //             callback({"status": "success", "code": SUCCESS});
  //         }
  //     });
};

exports.insert_multiple_rows = function (
  table_fields,
  object_array,
  table,
  callback
) {
  //todo example of object
  /*let site_obj = {
          site_name: site.site_name,
          address: (site.address == undefined) ? null : site.address,
          point: (site.point == undefined) ? null : site.point
      };*/
  // console.log(site);
  let query = "INSERT INTO " + table + table_fields + " VALUES ?";
  connection.query(query, object_array, function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({
        status: "success",
        code: SUCCESS,
        id: results.insertId
      });
      console.log(callback);
    }
  });
};

exports.execute_query = function (query, callback) {
  console.log(query);
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      callback({ status: "success", code: SUCCESS });
    }
  });
};
