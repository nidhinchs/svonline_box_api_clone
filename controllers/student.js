const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");

global.INSERT = "insert";
global.UPDATE = "update";
global.DELETE = "delete";

function getCurrentDateTime() {
  let moment = require("moment-timezone");
  return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}

function getCurrentDate() {
  let moment = require("moment-timezone");
  return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD");
}

exports.login = function (req, res) {
  let student_username = req.query.student_username;
  let student_password = req.query.student_password;


  common.selectAll("select * from student where student_username = '"+ student_username
   + "' and student_password = '"+student_password +"'",
    function (callback) {
    console.log(callback);
    if(callback.code == 200){

      common.selectAll("select * from student where 1"+
      " and start_date <='" +
      getCurrentDate() +
      "' and end_date >= '" +
      getCurrentDate() +
      "'",
      function (callback) {
        console.log(callback);
        if(callback.code == 200){
          res.json(callback);
        }else{
          res.json({
            status:"error",
            code:400,
            error:"Your subscription is ended. please contact admin."    
          });
          
        }
        
      }
      );

    }else{
      res.json({
        status:"error",
        code:400,
        error:"Your username or password is incorrect."

      });
    }
    // res.json(callback);
  });

  // common.selectAll(
  //   "select * from student where student_username = '" +
  //     student_username +
  //     "' and student_password = '" +
  //     student_password +
  //     "' and start_date <='" +
  //     getCurrentDate() +
  //     "' and end_date >= '" +
  //     getCurrentDate() +
  //     "'",
  //   function (callback) {
  //     console.log(callback);
  //     res.json(callback);
  //   }
  // );
};

exports.f_login = function (req, res) {
  let student_username = req.body.f_username;
  let student_password = req.body.f_password;

  common.selectAll(
    "select * from franchise where f_username = '" +
      student_username +
      "' and f_password = '" +
      student_password +
      "'",
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.check_student_status = function (req, res) {
  common.selectAll(
    "select count(*) as count from student where is_externally_added = 1",
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.get_profile = function (req, res) {
  let student_id = req.query.student_id;
  var total_courses = 0;
  var total_video = 0;
  var total_notes = 0;

  common.selectAll(
    "select * from student where student_id =" + student_id,
    function (call1) {
      console.log(call1);
      if (call1.code == SUCCESS) {
        common.select_first(
          "SELECT count(*) as quiz_attempted from (select * from quiz_result where student_id =" +
            student_id +
            " group by subject_id) as c",
          function (call2) {
            if (call2.code == SUCCESS) {
              call1.result[0]["quiz_attempted"] = call2.result.quiz_attempted;
              common.select_first(
                "select count(*) as total from subject where is_delete =0 and is_active =1",
                function (call5) {
                  if (call5.code == SUCCESS) {
                    call1.result[0]["total_quiz"] = call5.result.total;
                    console.log(call1);
                    common.selectAll(
                      "select max(progress) as progress from student_progress as p where p.type=1 and student_id =" +
                        student_id +
                        " group by type_id",
                      function (call3) {
                        common.select_first(
                          "select count(*) as total_videos from video where is_delete=0 and is_active =1",
                          function (call4) {
                            if (
                              call4.code == SUCCESS &&
                              call3.code == SUCCESS
                            ) {
                              call1.result[0]["total_video"] =
                                call4.result.total_videos;
                              console.log("success");
                              let sum = 0;
                              call3.result.forEach((progress) => {
                                console.log(progress);
                                sum += progress.progress;
                              });
                              console.log("sum : " + sum);
                              console.log("sum : " + call4.result.total_videos);
                              if (call4.result.total_videos > 0) {
                                call1.result[0]["video_progress"] =
                                  sum / call4.result.total_videos;
                              } else {
                                call1.result[0]["video_progress"] = 0;
                              }
                              common.select_first(
                                "select count(*) as total_notes from note where is_delete =0 and is_active = 1",
                                function (call6) {
                                  if (call6.code == SUCCESS) {
                                    call1.result[0]["total_notes"] =
                                      call6.result.total_notes;
                                  } else {
                                    call1.result[0]["total_notes"] = 0;
                                  }
                                  common.select_first(
                                    "select count(*) as total_courses from course where is_delete =0 and is_active = 1",
                                    function (call6) {
                                      if (call6.code == SUCCESS) {
                                        call1.result[0]["total_courses"] =
                                          call6.result.total_courses;
                                      } else {
                                        call1.result[0]["total_courses"] = 0;
                                      }
                                      res.json(call1);
                                    }
                                  );
                                  //res.json(call1);
                                }
                              );
                            } else {
                              console.log("fail");
                              call1.result[0]["video_progress"] = 0;
                              common.select_first(
                                "select count(*) as total_notes from note where is_delete =0 and is_active = 1",
                                function (call6) {
                                  if (call6.code == SUCCESS) {
                                    call1.result[0]["total_notes"] =
                                      call6.result.total_notes;
                                  } else {
                                    call1.result[0]["total_notes"] = 0;
                                  }
                                  common.select_first(
                                    "select count(*) as total_courses from course where is_delete =0 and is_active = 1",
                                    function (call6) {
                                      if (call6.code == SUCCESS) {
                                        call1.result[0]["total_courses"] =
                                          call6.result.total_courses;
                                      } else {
                                        call1.result[0]["total_courses"] = 0;
                                      }
                                      res.json(call1);
                                    }
                                  );
                                  //res.json(call1);
                                }
                              );
                            }
                          }
                        );
                      }
                    );
                  } else {
                    call1.result[0]["total_quiz"] = 0;
                  }
                }
              );
            } else {
              res.json(call1);
              console.log(call2);
            }
          }
        );
      } else {
        res.json(call1);
      }
    }
  );

  /*common.select_first("select * from student where student_id = " + student_id + ";SELECT count(*) as quiz_attempted from (select * from quiz_result where student_id =" + +student_id + " group by subject_id) as c;",
        function (call2) {
            console.log(call2);
            if (call2.code == SUCCESS) {
                call1.result['quiz_attempted'] = call2.result.
            }
        });*/
};

exports.add_student = function (req, res) {
  let result = req.body;

  let obj = {
    student_name: result.student_name,
    student_phone:
      result.student_phone == undefined ? null : result.student_phone,
    student_email:
      result.student_email == undefined ? null : result.student_email,
    student_address:
      result.student_address == undefined ? null : result.student_address,
    student_pic: result.student_pic == undefined ? null : result.student_pic,
    student_username:
      result.student_username == undefined ? null : result.student_username,
    student_password:
      result.student_password == undefined ? null : result.student_password,
    start_date: result.start_date == undefined ? null : result.start_date,
    end_date: result.end_date == undefined ? null : result.end_date,
    is_externally_added: 1,
    is_active: 1,
    is_delete: 1,
    created_by: result.f_id,
    created_date: getCurrentDateTime(),
  };

  common.select_first(
    "select * from student where student_phone = '" +
      result.student_phone +
      "' or student_username = '" +
      result.student_username +
      "'",
    function (call1) {
      if (call1.code == 200) {
        res.json({
          status: "error",
          code: "400",
          error: "Student already exist with this username or contact number.",
        });
      } else {
        common.insert(obj, "student", function (callback1) {
          res.json(callback1);
        });
      }
    }
  );
};
exports.add_student_attendance = function (req, res) {
  let result = req.body;

  let obj = {
    student_id: result.student_id,
    arriving_time: getCurrentDateTime(),
    created_by: result.f_id,
    created_date: getCurrentDateTime(),
  };

  common.insert(obj, "student_attendance", function (callback1) {
    console.log(callback1);
    res.json(callback1);
  });
};

exports.get_student = function (req, res) {
  common.selectAll("select * from student ", function (callback) {
    console.log(callback.code);
    res.json(callback);
  });
};
