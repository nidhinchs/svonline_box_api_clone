const fs = require('fs');
let common = require('./common');
let admin_common = require('./admin_common');

global.INSERT = "insert";
global.UPDATE = "update";
global.DELETE = "delete";


exports.login = function (req, res) {

    let student_username = req.query.student_username;
    let student_password = req.query.student_password;

    common.selectAll("select * from student where student_username = '" +
        student_username + "' and student_password = '" + student_password + "'", function (callback) {
        console.log(callback);
        res.json(callback);
    });
}

