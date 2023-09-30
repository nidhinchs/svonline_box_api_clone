var env = require("../config/config.json");

exports.config = function () {
  // var node_env = "test";
  // var node_env = "development";
  return env[node_env];
};
