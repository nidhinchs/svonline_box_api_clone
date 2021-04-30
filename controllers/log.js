let common = require('./common');

let moment = require("moment-timezone");

function getCurrentDateTime() {
    return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}


exports.send_log = function sendLog(type, response, error) {

    let log = {
        "type": type,
        "success": response,
        "error": error,
        "created_date": getCurrentDateTime()
    }
    common.insert(log, "log", function (callback) {
        console.log(callback);
    });
}

