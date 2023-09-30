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

exports.signout = function (req, res) {
  let student_id = req.query.student_id;

  let obj = {
    student_id: student_id,
    log_name: "logout",
    log_time: getCurrentDateTime(),
    created_date: getCurrentDateTime()
  };

  common.insert(obj, "student_log", function (call2) {
    res.json(call2);
  });
};

exports.login = function (req, res) {
  let student_username = req.query.student_username;
  let student_password = req.query.student_password;
  let unique_id = req.query.unique_id;

  common.selectAll(
    "select * from student where student_username = '" +
      student_username +
      "' and student_password = '" +
      student_password +
      "'",
    function (callback) {
      console.log(callback);
      if (callback.code == 200) {
        common.selectAll(
          "select * from student where student_username = '" +
            student_username +
            "' and student_password = '" +
            student_password +
            "' and" +
            " start_date <='" +
            getCurrentDate() +
            "' and end_date >= '" +
            getCurrentDate() +
            "'",
          function (callback1) {
            console.log(callback1);
            if (callback1.code == 200) {
              console.log(callback1.result[0].unique_id);
              if (
                callback1.result[0].unique_id == "" ||
                callback1.result[0].unique_id == undefined
              ) {
                common.execute_query(
                  "update student set unique_id = '" +
                    unique_id +
                    "' where student_username = '" +
                    student_username +
                    "' and student_password = '" +
                    student_password +
                    "'",
                  function (call1) {
                    let obj = {
                      student_id: callback1.student_id,
                      log_name: "login",
                      log_time: getCurrentDateTime(),
                      created_date: getCurrentDateTime()
                    };

                    common.insert(obj, "student_log", function (call2) {
                      res.json(callback1);
                    });
                  }
                );
              } else if (callback1.result[0].unique_id == unique_id) {
                let obj = {
                  student_id: callback1.student_id,
                  log_name: "login",
                  log_time: getCurrentDateTime(),
                  created_date: getCurrentDateTime()
                };

                common.insert(obj, "student_log", function (call2) {
                  res.json(callback1);
                });
              } else {
                res.json({
                  status: "error",
                  code: "500",
                  error:
                    "You previously login with some another device. Please contact admin for change device."
                });
              }
            } else {
              res.json({
                status: "error",
                code: "700",
                error: "Your subscription is ended. please contact admin."
              });
            }
          }
        );
      } else {
        res.json({
          status: "error",
          code: "500",
          error: "Your username or password is incorrect."
        });
      }
      // res.json(callback);
    }
  );

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

exports.check_device_for_reset_pwd = function (req, res) {
  let student_username = req.query.student_username;
  let unique_id = req.query.unique_id;

  common.selectAll(
    "select * from student where student_username = '" +
      student_username +
      "' and unique_id = '" +
      unique_id +
      "'",
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.change_pwd = function (req, res) {
  let student_username = req.query.student_username;
  let student_password = req.query.student_password;

  let obj = {
    student_password: student_password
  };

  common.update(
    obj,
    "student_username",
    student_username,
    "student",
    function (call1) {
      res.json(call1);
    }
  );
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
    function (callback1) {
      if (callback1.code == 200) {
        console.log(callback1);
        if (
          callback1.result[0].unique_id == "" ||
          callback1.result[0].unique_id == undefined
        ) {
          common.execute_query(
            "update franchise set unique_id = '" +
              unique_id +
              "' where f_username = '" +
              student_username +
              "' and f_password = '" +
              student_password +
              "'",
            function (call1) {
              console.log(call1);
              res.json(callback1);
            }
          );
        } else if (callback1.result[0].unique_id == unique_id) {
          res.json(callback1);
        } else {
          res.json({
            status: "error",
            code: "500",
            error:
              "You previously login with some another device. Please contact admin for change device."
          });
        }
      } else {
      }

      // res.json(callback);
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
    created_date: getCurrentDateTime()
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
          error: "Student already exist with this username or contact number."
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
    created_date: getCurrentDateTime()
  };

  common.insert(obj, "student_attendance", function (callback1) {
    console.log(callback1);
    res.json(callback1);
  });
};

exports.call_reset_device = function (req, res) {
  let result = req.body;

  common.execute_query(
    "update student set unique_id = NULL where student_id = " +
      result.student_id,
    function (callback1) {
      console.log(callback1);
      res.json(callback1);
    }
  );
};

exports.get_student = function (req, res) {
  let query =
    "SELECT  s.*,  a.arriving_time FROM  student AS s LEFT JOIN  student_attendance AS a ON  s.student_id = a.student_id  AND DATE(a.created_date) = CURDATE();";
  common.selectAll(query, function (callback) {
    console.log(callback.code);
    res.json(callback);
  });
};
