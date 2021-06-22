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

    common.selectAll("select * from subject where course_id = " + course_id, function (callback) {
        console.log(callback);
        res.json(callback);
    });

}

exports.get_video = function (req, res) {

    let subject_id = req.query.subject_id;

    common.selectAll("select * from video where subject_id = " + subject_id, function (callback) {
        console.log(callback);
        res.json(callback);
    });

}

exports.get_note = function (req, res) {

    let subject_id = req.query.subject_id;

    common.selectAll("select * from note where subject_id = " + subject_id, function (callback) {
        console.log(callback);
        res.json(callback);
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
                        if (idx == result.result_detail.length-1) {
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


