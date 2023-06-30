const fs = require("fs");
let common = require("./common");
let config = require("../config/config").config();
let admin_common = require("./admin_common");


exports.check_connection = function(req,res){
    admin_common.select_first(
        "select * from box_update_status where box_id = " + request.box_id,
        function (callback1) {
}