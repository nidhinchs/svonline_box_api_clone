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
    log_action: "logout",
    log_date: getCurrentDateTime()
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
exports.f_check_device_for_reset_pwd = function (req, res) {
  let student_username = req.query.f_username;
  let unique_id = req.query.unique_id;

  common.selectAll(
    "select * from franchise where f_username = '" +
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
exports.f_change_pwd = function (req, res) {
  let student_username = req.query.f_username;
  let student_password = req.query.f_password;

  let obj = {
    f_password: student_password
  };

  common.update(
    obj,
    "f_username",
    student_username,
    "franchise",
    function (call1) {
      res.json(call1);
    }
  );
};

exports.f_login = function (req, res) {
  let student_username = req.body.f_username;
  let student_password = req.body.f_password;
  let unique_id = req.body.unique_id;

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
        res.json(callback1);
      }
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

exports.get_profile = async function (req, res) {
  try {
    let student_id = parseInt(req.query.student_id, 10);

    if (isNaN(student_id)) {
      return res.json({
        code: "400",
        status: "fail",
        message: "Invalid student_id parameter."
      });
    }

    // 1. Fetch Student Profile
    const studentData = await new Promise((resolve) =>
      common.selectAll(`SELECT * FROM student WHERE student_id = ${student_id}`, resolve)
    );

    if (studentData.code !== SUCCESS || !studentData.result.length) {
      return res.json(studentData);
    }

    let profile = studentData.result[0];

    // 2. Fetch all dependent stats in parallel
    const [
      quizAttemptedRes,
      totalSubjectsRes,
      studentProgressRes,
      totalVideosRes,
      totalNotesRes,
      totalCoursesRes
    ] = await Promise.all([
      // Count distinct subjects attempted in quiz_result
      new Promise((res) =>
        common.select_first(
          `SELECT COUNT(DISTINCT subject_id) AS quiz_attempted FROM quiz_result WHERE student_id = ${student_id}`,
          res
        )
      ),
      // Active subjects (Used as total_quiz in UI)
      new Promise((res) =>
        common.select_first(
          `SELECT COUNT(*) AS total FROM subject WHERE is_delete = 0 AND is_active = 1`,
          res
        )
      ),
      // Progress array for videos
      new Promise((res) =>
        common.selectAll(
          `SELECT MAX(progress) AS progress FROM student_progress WHERE type = 1 AND student_id = ${student_id} GROUP BY type_id`,
          res
        )
      ),
      // Total Videos
      new Promise((res) =>
        common.select_first(
          `SELECT COUNT(*) AS total_videos FROM video WHERE is_delete = 0 AND is_active = 1`,
          res
        )
      ),
      // Total Notes
      new Promise((res) =>
        common.select_first(
          `SELECT COUNT(*) AS total_notes FROM note WHERE is_delete = 0 AND is_active = 1`,
          res
        )
      ),
      // Total Courses
      new Promise((res) =>
        common.select_first(
          `SELECT COUNT(*) AS total_courses FROM course WHERE is_delete = 0 AND is_active = 1`,
          res
        )
      )
    ]);

    // 3. Process aggregates and attach to response
    profile.quiz_attempted = quizAttemptedRes?.result?.quiz_attempted || 0;
    profile.total_quiz = totalSubjectsRes?.result?.total || 0;
    profile.total_notes = totalNotesRes?.result?.total_notes || 0;

    // NOTE: Replace this query with an enrollment table check (e.g. `student_course`) 
    // if courses are student-specific in your DB design.
    profile.total_courses = totalCoursesRes?.result?.total_courses || 0;

    // Calculate video progress ratio
    let totalVideos = totalVideosRes?.result?.total_videos || 0;
    profile.total_video = totalVideos;

    if (totalVideos > 0 && studentProgressRes.code === SUCCESS && Array.isArray(studentProgressRes.result)) {
      let sum = studentProgressRes.result.reduce((acc, curr) => acc + (curr.progress || 0), 0);
      profile.video_progress = sum / totalVideos;
    } else {
      profile.video_progress = 0;
    }

    return res.json(studentData);
  } catch (error) {
    return res.json({
      code: "500",
      status: "failed",
      message: "Internal server error",
      error: error.message
    });
  }
};

// exports.get_profile = function (req, res) {
//   let student_id = req.query.student_id;
//   var total_courses = 0;
//   var total_video = 0;
//   var total_notes = 0;

//   common.selectAll(
//     "select * from student where student_id =" + student_id,
//     function (call1) {
//       console.log(call1);
//       if (call1.code == SUCCESS) {
//         let query =
//           "SELECT count(*) as quiz_attempted from (select * from quiz_result where student_id =" +
//           student_id +
//           " group by subject_id) as c";

//         let q = `SELECT COUNT(DISTINCT subject_id) AS quiz_attempted 
//         FROM quiz_result 
//         WHERE student_id = ${student_id};`;

//         common.select_first(q, function (call2) {
//           if (call2.code == SUCCESS) {
//             call1.result[0]["quiz_attempted"] = call2.result.quiz_attempted;
//             common.select_first(
//               "select count(*) as total from subject where is_delete =0 and is_active =1",
//               function (call5) {
//                 if (call5.code == SUCCESS) {
//                   call1.result[0]["total_quiz"] = call5.result.total;
//                   console.log(call1);
//                   common.selectAll(
//                     "select max(progress) as progress from student_progress as p where p.type=1 and student_id =" +
//                       student_id +
//                       " group by type_id",
//                     function (call3) {
//                       common.select_first(
//                         "select count(*) as total_videos from video where is_delete=0 and is_active =1",
//                         function (call4) {
//                           if (call4.code == SUCCESS && call3.code == SUCCESS) {
//                             call1.result[0]["total_video"] =
//                               call4.result.total_videos;
//                             console.log("success");
//                             let sum = 0;
//                             call3.result.forEach((progress) => {
//                               console.log(progress);
//                               sum += progress.progress;
//                             });
//                             console.log("sum : " + sum);
//                             console.log("sum : " + call4.result.total_videos);
//                             if (call4.result.total_videos > 0) {
//                               call1.result[0]["video_progress"] =
//                                 sum / call4.result.total_videos;
//                             } else {
//                               call1.result[0]["video_progress"] = 0;
//                             }
//                             common.select_first(
//                               "select count(*) as total_notes from note where is_delete =0 and is_active = 1",
//                               function (call6) {
//                                 if (call6.code == SUCCESS) {
//                                   call1.result[0]["total_notes"] =
//                                     call6.result.total_notes;
//                                 } else {
//                                   call1.result[0]["total_notes"] = 0;
//                                 }
//                                 common.select_first(
//                                   "select count(*) as total_courses from course where is_delete =0 and is_active = 1",
//                                   function (call6) {
//                                     if (call6.code == SUCCESS) {
//                                       call1.result[0]["total_courses"] =
//                                         call6.result.total_courses;
//                                     } else {
//                                       call1.result[0]["total_courses"] = 0;
//                                     }
//                                     res.json(call1);
//                                   }
//                                 );
//                                 //res.json(call1);
//                               }
//                             );
//                           } else {
//                             console.log("fail");
//                             call1.result[0]["video_progress"] = 0;
//                             common.select_first(
//                               "select count(*) as total_notes from note where is_delete =0 and is_active = 1",
//                               function (call6) {
//                                 if (call6.code == SUCCESS) {
//                                   call1.result[0]["total_notes"] =
//                                     call6.result.total_notes;
//                                 } else {
//                                   call1.result[0]["total_notes"] = 0;
//                                 }
//                                 common.select_first(
//                                   "select count(*) as total_courses from course where is_delete =0 and is_active = 1",
//                                   function (call6) {
//                                     if (call6.code == SUCCESS) {
//                                       call1.result[0]["total_courses"] =
//                                         call6.result.total_courses;
//                                     } else {
//                                       call1.result[0]["total_courses"] = 0;
//                                     }
//                                     res.json(call1);
//                                   }
//                                 );
//                                 //res.json(call1);
//                               }
//                             );
//                           }
//                         }
//                       );
//                     }
//                   );
//                 } else {
//                   call1.result[0]["total_quiz"] = 0;
//                 }
//               }
//             );
//           } else {
//             res.json(call1);
//             console.log(call2);
//           }
//         });
//       } else {
//         res.json(call1);
//       }
//     }
//   );

  /*common.select_first("select * from student where student_id = " + student_id + ";SELECT count(*) as quiz_attempted from (select * from quiz_result where student_id =" + +student_id + " group by subject_id) as c;",
        function (call2) {
            console.log(call2);
            if (call2.code == SUCCESS) {
                call1.result['quiz_attempted'] = call2.result.
            }
        });*/
// };

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

exports.get_attendance_report = function (req, res) {
  let item = req.query;

  let start_date = item.start_date;
  let end_date = item.end_date;

  let query =
    "SELECT  sa.student_id,  s.student_name," +
    "DATEDIFF('" +
    end_date +
    "', '" +
    start_date +
    "') + 1 AS total_days,  " +
    "COUNT(DISTINCT CASE WHEN sa.arriving_time IS NOT NULL THEN DATE(sa.created_date) END) AS present_days, " +
    " (DATEDIFF('" +
    end_date +
    "', '" +
    start_date +
    "') + 1 - COUNT(DISTINCT CASE WHEN sa.arriving_time IS NOT NULL THEN DATE(sa.created_date) END)) AS absent_days, " +
    " (COUNT(DISTINCT CASE WHEN sa.arriving_time IS NOT NULL THEN DATE(sa.created_date) END) / (DATEDIFF('" +
    end_date +
    "', '" +
    start_date +
    "') + 1)) * 100 AS percentage " +
    "FROM  student_attendance AS sa JOIN   student AS s ON   sa.student_id = s.student_id WHERE  DATE(sa.created_date) BETWEEN '" +
    start_date +
    "' AND '" +
    end_date +
    "' GROUP BY  sa.student_id, s.student_name";
  common.selectAll(query, function (call1) {
    res.json(call1);
  });
};

exports.get_attendance_report_by_student = function (req, res) {
  let item = req.query;

  let start_date = item.start_date;
  let end_date = item.end_date;
  let student_id = item.student_id;

  let query =
    "SELECT    sa.student_id,   s.student_name,   DATE(sa.created_date) AS attendance_date,   sa.arriving_time,   sa.leaving_time " +
    "FROM " +
    "student_attendance AS sa JOIN " +
    " student  s" +
    " ON" +
    "  sa.student_id = s.student_id " +
    "WHERE " +
    "  sa.student_id = '" +
    student_id +
    "'" +
    "AND DATE(sa.created_date) BETWEEN '" +
    start_date +
    "' AND '" +
    end_date +
    "'" +
    "ORDER BY attendance_date";

  let query1 =
    "SELECT d.date AS attendance_date,s.student_id,s.student_name,sa.arriving_time FROM" +
    "(SELECT  DATE('" +
    start_date +
    "' + INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY) AS date FROM( SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a        CROSS JOIN(SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b CROSS JOIN(                SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL                SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9            ) AS c    ) AS d LEFT JOIN    student AS s ON     s.student_id = '" +
    student_id +
    "' LEFT JOIN    student_attendance AS sa ON     s.student_id = sa.student_id      AND DATE(sa.created_date) = d.date WHERE     d.date BETWEEN '" +
    start_date +
    "' AND '" +
    end_date +
    "' ORDER BY     d.date;";

  common.selectAll(query1, function (call1) {
    res.json(call1);
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
