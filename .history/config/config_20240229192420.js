var env = require("../config/config.json");

exports.config = function () {
  // var node_env = "test";
  // var node_env = "development";
  // var node_env = "server";
  return env[node_env];
};
