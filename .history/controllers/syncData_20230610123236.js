const fs = require("fs");
let common = require("./common");
let config = require("../config/config").config();
let admin_common = require("./admin_common");


exports.check_connection = function(req,res){

    let data = req.query;

    let obj = {
        device_id : data.device_id,
        device_mac_address : data.device_mac_address,

    }
    admin_common.select_first(
        "select * from  where box_id = " + request.box_id,
        function (callback1) {});
}