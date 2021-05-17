const fs = require('fs');
let common = require('./common');
let admin_common = require('./admin_common');

global.INSERT = "insert";
global.UPDATE = "update";
global.DELETE = "delete";


exports.update_database_data = function (req, res) {

    let last_log_id = "0";

    common.select_first("select log_id from db_log order by log_id desc", function (callback) {

        if (callback.code == SUCCESS) {
            last_log_id = callback.result.log_id;
            admin_common.selectAll("select * from db_log where log_id > " + last_log_id, function (call1) {
                if (call1.code == SUCCESS) {
                    exec_query(call1.result, function (call2) {
                        res.json(call2);
                    });
                } else if (call1.code == ERROR_EMPTY) {
                    res.json({
                        code: SUCCESS,
                        message: "already updated"
                    });
                } else {
                    res.json(call1);
                }

            });
        }
    });


}

async function exec_query(result, callback1) {
    for await(const [i, query] of result.entries()) {
        await insertUpdateInLocal(query, function (callback) {
            console.log(i);
            if (i == result.length - 1) {
                console.log("========================================in last =======================")
                callback1({
                    code: SUCCESS,
                    message: "updated successfully"
                });
                console.log("========================================in last =======================")
            }
        });

    }
}

async function insert_log(query, callback) {
    console.log(query);
    await common.insert(Object.assign({}, query), "db_log", function (call4) {
        callback(call4);
    });
}

async function insertUpdateInLocal(query, callback) {
    if (query.trigger_type == INSERT || query.trigger_type == UPDATE) {
        let selectData = " select * from " + query.table_name + " where " + query.primary_key + " = " +
            query.primary_key_value;

        await admin_common.select_first(selectData, function (call3) {
            console.log(call3.result);
            if (call3.code == SUCCESS) {
                if (query.trigger_type == INSERT) {

                    common.insert(Object.assign({}, call3.result), query.table_name, function (call1) {
                        console.log(call1)
                        if (call1.code == SUCCESS) {
                            insert_log(query, function (call5) {
                                callback(call5);
                            });


                        } else {
                            callback(call1);
                        }
                    });

                } else if (query.trigger_type == UPDATE) {

                    common.update(Object.assign({}, call3.result),
                        query.primary_key,
                        query.primary_key_value,
                        query.table_name, function (call1) {

                            console.log(call1)
                            if (call1.code == SUCCESS) {
                                insert_log(query, function (call5) {
                                    callback(call5);
                                });


                            } else {
                                callback(call1);
                            }

                        })

                } else {
                    console.log("unknown action");
                    console.log("unknown action");
                }

            } else {
                callback(call3);
            }
        });
    } else if (query.trigger_type == DELETE) {
        common.delete(query.primary_key,
            query.primary_key_value,
            query.table_name, function (call1) {

                console.log(call1);
                if (call1.code == SUCCESS) {
                    insert_log(query, function (call5) {
                        callback(call5);
                    });


                } else {
                    callback(call1);
                }
            });

    }
}


