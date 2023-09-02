const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");
let config = require("../config/config").config();

exports.update_content_server_to_box = function (req, res) {
  check_connection(function (connected) {
    if (connected == 1) {
common.selectAll("select * from courses")
    } else {
      res.json({
        code: 400,
        status: "error",
        error: "Internet connection is not available."
      });
    }
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
