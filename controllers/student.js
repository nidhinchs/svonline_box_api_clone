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

exports.get_profile = function (req, res) {

    let student_id = req.query.student_id;
    var total_courses = 0;
    var total_video = 0;
    var total_notes =0;

    common.selectAll("select * from student where student_id =" + student_id, function (call1) {
        console.log(call1);
        if (call1.code == SUCCESS) {
            common.select_first("SELECT count(*) as quiz_attempted from (select * from quiz_result where student_id =" + student_id + " group by subject_id) as c", function (call2) {
                if (call2.code == SUCCESS) {
                    call1.result[0]['quiz_attempted'] = call2.result.quiz_attempted;
                    common.select_first("select count(*) as total from subject where is_delete =0 and is_active =1", function (call5) {
                        if (call5.code == SUCCESS) {
                            call1.result[0]['total_quiz'] = call5.result.total;
                            console.log(call1);
                            common.selectAll("select max(progress) as progress from student_progress as p where p.type=1 and student_id =" + student_id + " group by type_id", function (call3) {
                                common.select_first("select count(*) as total_videos from video where is_delete=0 and is_active =1", function (call4) {
                                    if (call4.code == SUCCESS && call3.code == SUCCESS) {
                                        call1.result[0]['total_video'] = call4.result.total_videos;
                                        console.log("success");
                                        let sum = 0;
                                        call3.result.forEach(progress => {
                                            console.log(progress);
                                            sum += progress.progress;
                                        });
                                        console.log("sum : " + sum);
                                        console.log("sum : " + call4.result.total_videos);
                                        if (call4.result.total_videos > 0) {
                                            call1.result[0]['video_progress'] = sum / call4.result.total_videos;
                                        } else {
                                            call1.result[0]['video_progress'] = 0;
                                        }
                                        common.select_first("select count(*) as total_notes from note where is_delete =0 and is_active = 1",function (call6) {
                                            if(call6.code == SUCCESS){
                                                call1.result[0]['total_notes'] = call6.result.total_notes;
                                            }else{
                                                call1.result[0]['total_notes'] = 0;
                                            }
                                            common.select_first("select count(*) as total_courses from course where is_delete =0 and is_active = 1",function (call6) {
                                                if(call6.code == SUCCESS){
                                                    call1.result[0]['total_courses'] = call6.result.total_courses;
                                                }else{
                                                    call1.result[0]['total_courses'] = 0;
                                                }
                                                res.json(call1);
                                            });
                                            //res.json(call1);
                                        });


                                    } else {
                                        console.log("fail");
                                        call1.result[0]['video_progress'] = 0;
                                        common.select_first("select count(*) as total_notes from note where is_delete =0 and is_active = 1",function (call6) {
                                            if(call6.code == SUCCESS){
                                                call1.result[0]['total_notes'] = call6.result.total_notes;
                                            }else{
                                                call1.result[0]['total_notes'] = 0;
                                            }
                                            common.select_first("select count(*) as total_courses from course where is_delete =0 and is_active = 1",function (call6) {
                                                if(call6.code == SUCCESS){
                                                    call1.result[0]['total_courses'] = call6.result.total_courses;
                                                }else{
                                                    call1.result[0]['total_courses'] = 0;
                                                }
                                                res.json(call1);
                                            });
                                            //res.json(call1);
                                        });

                                    }
                                });
                            });
                        } else {
                            call1.result[0]['total_quiz'] = 0;
                        }
                    });
                } else {
                    res.json(call1);
                    console.log(call2);
                }
            });
        } else {
            res.json(call1);
        }
    });

    /*common.select_first("select * from student where student_id = " + student_id + ";SELECT count(*) as quiz_attempted from (select * from quiz_result where student_id =" + +student_id + " group by subject_id) as c;",
        function (call2) {
            console.log(call2);
            if (call2.code == SUCCESS) {
                call1.result['quiz_attempted'] = call2.result.
            }
        });*/


}



