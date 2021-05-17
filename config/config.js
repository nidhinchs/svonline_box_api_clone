var env = require('../config/config.json');

exports.config = function() {
    var node_env = 'test';
    return env[node_env];
};