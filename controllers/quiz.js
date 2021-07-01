const fs = require('fs');
let common = require('./common');
let admin_common = require('./admin_common');

global.INSERT = "insert";
global.UPDATE = "update";
global.DELETE = "delete";


exports.get_quiz = function (req, res) {

    let subject_id = req.query.subject_id;

    common.selectAll("select * from quiz where subject_id = " + subject_id + " order by rand() limit 20", function (callback) {
        console.log(callback);
        res.json(callback);
    });


}

exports.get_course = function (req, res) {


    common.selectAll("select * from course", function (callback) {
        console.log(callback);
        res.json(callback);
    });


}

exports.get_subject = function (req, res) {

    let course_id = req.query.course_id;

    common.selectAll("select * from subjects where course_id = " + course_id, function (callback) {
        console.log(callback);
        res.json(callback);
    });

}

exports.get_video = function (req, res) {

    let subject_id = req.query.subject_id;

    common.selectAll("select * from videos where subject_id = " + subject_id, function (callback) {
        console.log(callback);
        res.json(callback);
    });

}

exports.get_note = function (req, res) {

    let subject_id = req.query.subject_id;

    common.selectAll("select * from note where subject_id = " + subject_id, function (callback) {
        console.log(callback.code);
        res.json(callback);
    });

}

exports.get_result = function (req, res) {

    let student_id = req.query.student_id;

    common.selectAll("select * from quiz_results where student_id = " + student_id, function (call) {
        res.json(call);
    });
}
exports.get_result_detail = function (req, res) {

    let result_id = req.query.result_id;

    common.selectAll("select * from quiz_results where result_id = " + result_id, function (call) {
        if (call.code == SUCCESS) {
            common.selectAll("select * from quiz_result_details where result_id = " + result_id, function (call2) {
                call.result[0]['quiz'] = call2.result;
                res.json(call);
            });
        } else {
            res.json(call);
        }

    });
}

exports.add_progress = function(req,res){
    let result = req.body;

    let obj = {
        box_id : result.box_id,
        student_id: result.student_id,
        subject_id : result.subject_id,
        type : result.type,
        type_id : result.type_id,
        progress: result.progress,
        is_active: 1,
        is_delete: 1,
        created_by: result.student_id,
        created_date: getCurrentDateTime()
    };
    common.insert(obj, "student_progress", function (callback1) {
        res.json(callback1);
    });

}

exports.add_result = function (req, res) {
    let result = req.body;

    let obj = {
        student_id: result.student_id,
        total_score: result.total_score,
        obtained_score: result.obtained_score,
        subject_id: result.subject_id,
        total_time: result.total_time,
        time_to_complete: result.time_to_complete,
        is_active: 1,
        is_delete: 1,
        created_by: result.student_id,
        created_date: getCurrentDateTime()
    };

    common.insert(obj, "quiz_result", function (callback1) {
        if (callback1.code == SUCCESS) {
            result.result_detail.forEach(async (result_detail, idx) => {
                await insert_result_detail(
                    result.student_id,
                    callback1.cust_id,
                    result_detail,
                    function (callback2) {
                        if (idx == result.result_detail.length - 1) {
                            res.json(callback1);
                        }
                    });
            });
        } else {
            res.json(callback1);
        }
    })
}



function insert_result_detail(student_id, result_id, result_detail, callback) {
    let obj = {
        result_id: result_id,
        quiz_id: result_detail.quiz_id,
        selected_answer: result_detail.selected_answer,
        right_answer: result_detail.right_answer,
        is_delete: 0,
        is_active: 1,
        created_by: student_id,
        created_date: getCurrentDateTime()

    };
    common.insert(obj, "quiz_result_detail", function (call) {
        console.log(call.code);
        callback(call);
    })
}


