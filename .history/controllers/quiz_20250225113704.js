const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");

global.INSERT = "insert";
global.UPDATE = "update";
global.DELETE = "delete";

exports.get_quiz = function (req, res) {
  let subject_id = req.query.subject_id;

  common.selectAll(
    "select * from quiz where subject_id = " +
      subject_id +
      " order by rand() limit 20",
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.get_all_quiz = function (req, res) {
  let subject_id = req.query.subject_id;

  common.selectAll(
    "select * from quiz where subject_id = " + subject_id,
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.get_course = function (req, res) {
  common.selectAll("select * from course", function (callback) {
    console.log(callback);
    res.json(callback);
  });
};

exports.get_subject = async function (req, res) {
  let course_id = req.query.course_id;
  let student_id = req.query.student_id;

  let query = `SELECT 
  s.subject_id,
  s.course_id,
  s.subject_name,
  s.subject_desc,
  s.note_name,
  s.note_url,
  s.created_by,
  s.created_date,
  s.ip_address,
  s.is_active,
  s.is_delete,
  s.modified_by,
  s.modified_date,
  COALESCE(MAX(CASE WHEN sp.type = 1 THEN sp.progress END), 0) AS max_video_progress,
  COALESCE(qs.obtained_score, 0) AS max_score,
  COALESCE(qs.attempt_count, 0) AS quiz_attempt_count
FROM 
  subject s
LEFT JOIN 
  student_progress sp ON s.subject_id = sp.subject_id AND sp.student_id = ${student_id}
LEFT JOIN 
  (
      SELECT 
          q.subject_id,
          q.student_id,
          MAX(q.obtained_score) AS obtained_score,
          COUNT(*) AS attempt_count
      FROM 
          quiz_result q
      WHERE 
          q.student_id = ${student_id}
      GROUP BY 
          q.subject_id, q.student_id
  ) qs ON s.subject_id = qs.subject_id AND sp.student_id = qs.student_id where s.course_id = ${course_id}
GROUP BY 
  s.subject_id
ORDER BY 
  s.subject_id;`;
  common.selectAll(query, function (callback) {
    res.json(callback);
  });
};

// exports.get_subject = async function (req, res) {
//   let course_id = req.query.course_id;
//   let student_id = req.query.student_id;

//   common.selectAll(
//     "select * from subject where course_id = " + course_id,
//     function (callback) {
//       console.log(callback);
//       if (callback.code == SUCCESS) {
//         callback.result.forEach((subject, index) => {
//            common.select_first(
//             "select sum(progress) as total_progress,total_video from video_progress where subject_id = " +
//               subject.subject_id +
//               " and student_id = " +
//               student_id,
//             async function (call1) {
//               if (call1.code == SUCCESS) {
//                 subject["video_progress"] =
//                   call1.result.total_progress / call1.result.total_video;
//               } else {
//                 subject["video_progress"] = 0;
//               }

//               await common.select_first(
//                 "select score,quiz_attempt_count from quiz_scores where subject_id = " +
//                   subject.subject_id +
//                   " and student_id = " +
//                   student_id,
//                 function (call2) {
//                   console.log(call2);
//                   if (call2.code == SUCCESS) {
//                     subject["score"] = call2.result.score;
//                     subject["quiz_attempt_count"] =
//                       call2.result.quiz_attempt_count;

//                     if (index == callback.result.length - 1) {
//                       console.log("index matched");
//                       res.json(callback);
//                     }
//                   } else {
//                     subject["score"] = null;
//                     subject["quiz_attempt_count"] = 0;

//                     // if (index == callback.result.length - 1) {
//                     //   console.log("index matched");
//                     //   res.json(callback);
//                     // }
//                   }
//                 }
//               );
//             }
//           );
//           /*  await get_progress(student_id, subject, index, function (call) {

//                       subject['video_progress'] = call.progress;

//                       if (index == callback.result.length - 1) {
//                           console.log("index matched");
//                           res.json(callback);
//                       }
//                   });*/
//         });
//         console.log(callback);
//         res.json(callback);

//       } else {
//         res.json(callback);
//       }
//     }
//   );
// };

async function get_progress(student_id, subject, index, callback1) {
  console.log(index + " : index");
  common.select_first(
    "select count(*) as total_videos from video where is_delete=0 and is_active =1 and subject_id = " +
      subject.subject_id,
    function (call4) {
      if (call4.code == SUCCESS) {
        if (call4.result.total_videos > 0) {
          common.selectAll(
            "select max(progress) as progress from student_progress as p where p.type=1 and subject_id = " +
              subject.subject_id +
              " and student_id =" +
              student_id +
              " group by type_id",
            function (call3) {
              console.log(call3);
              if (call3.code == SUCCESS) {
                let sum = 0;
                call3.result.forEach((progress) => {
                  console.log(progress);
                  sum += progress.progress;
                });
                callback1({ progress: sum / call4.result.total_videos });
              } else {
                callback1({ progress: 0 });
              }
            }
          );
          // callback1({progress: sum / call4.result.total_videos});
          // console.log("progress : " + (subject['video_progress']));
        } else {
          callback1({ progress: 0 });
        }
      } else {
        callback1({ progress: 0 });
      }
    }
  );
  /*  await common.selectAll("select max(progress) as progress from student_progress as p where p.type=1 and subject_id = " + subject.subject_id + " and student_id =" + student_id + " group by type_id", function (call3) {
          if (call3.code == SUCCESS) {
              let sum = 0;
              call3.result.forEach(progress => {
                  console.log(progress);
                  sum += progress.progress;
              });
              common.select_first("select count(*) as total_videos from video where is_delete=0 and is_active =1 and subject_id = " + subject.subject_id, function (call4) {
                  if (call4.code == SUCCESS) {
                      if (call4.result.total_videos > 0) {
                          callback1({progress: sum / call4.result.total_videos});
                          console.log("progress : " + (subject['video_progress']));
                      } else {
                          callback1({progress: 0});
                      }
                  } else {
                      callback1({progress: 0});
                  }
              });
          } else {
              callback1({progress: 0});
          }
      });*/
}

exports.get_video = function (req, res) {
  let subject_id = req.query.subject_id;
  let student_id = req.query.student_id;

  let query = `SELECT 
  v.*,
  COALESCE(MAX(sp.progress), 0) AS max_progress
FROM 
  video v
LEFT JOIN 
  student_progress sp ON v.video_id = sp.type_id AND sp.type = 1 AND sp.student_id = ${student_id}
  where v.subject_id = ${subject_id}
GROUP BY 
  v.video_id, 
  v.video_name, 
  v.video_desc, 
  v.video_path, 
  v.video_extension,
  v.created_by,
  v.created_date,
  v.ip_address,
  v.is_active,
  v.is_delete,
  v.modified_by,
  v.modified_date
ORDER BY 
  v.video_id;`;

  common.selectAll(query, function (call1) {
    console.log(call1);
    res.json(call1);
  });
};

// exports.get_video = function (req, res) {
//   let subject_id = req.query.subject_id;
//   let student_id = req.query.student_id;

//   common.selectAll(
//     "select * from video where subject_id = " + subject_id,
//     function (call1) {
//       console.log(call1);
//       if (call1.code == SUCCESS) {
//         call1.result.forEach((video, index) => {
//           console.log(index);
//           common.select_first(
//             "select max(progress) as progress from student_progress where type=1 and type_id = " +
//               video.video_id +
//               " and student_id = " +
//               student_id,
//             function (call2) {
//               if (call2.code == SUCCESS) {
//                 video["progress"] = call2.result.progress;
//               } else {
//                 video["progress"] = 0;
//               }

//               if (index == call1.result.length - 1) {
//                 res.json(call1);
//               }
//             }
//           );
//         });
//       } else {
//         res.json(call1);
//       }
//     }
//   );

//   /* common.selectAll("select * from videos where subject_id = " + subject_id, function (callback) {
//          console.log(callback);
//          res.json(callback);
//      });*/
// };

exports.get_note = function (req, res) {
  let subject_id = req.query.subject_id;

  common.selectAll(
    "select * from note where subject_id = " + subject_id,
    function (callback) {
      console.log(callback.code);
      res.json(callback);
    }
  );
};

exports.get_result = function (req, res) {
  let student_id = req.query.student_id;

  common.selectAll(
    "select * from quiz_results where student_id = " +
      student_id +
      " order by created_date desc",
    function (call) {
      res.json(call);
    }
  );
};
exports.get_result_detail = function (req, res) {
  let result_id = req.query.result_id;

  common.selectf(
    "select * from quiz_results where result_id = " + result_id,
    function (call) {
      if (call.code == SUCCESS) {
        common.selectAll(
          "select * from quiz_result_details where result_id = " + result_id,
          function (call2) {
            call.result[0]["quiz"] = call2.result;
            res.json(call);
          }
        );
      } else {
        res.json(call);
      }
    }
  );
};

exports.add_progress = function (req, res) {
  let result = req.body;

  let obj = {
    box_id: result.box_id,
    student_id: result.student_id,
    subject_id: result.subject_id,
    type: result.type,
    type_id: result.type_id,
    progress: result.progress,
    is_active: 1,
    is_delete: 1,
    created_by: result.student_id,
    created_date: getCurrentDateTime()
  };
  common.insert(obj, "student_progress", function (callback1) {
    res.json(callback1);
  });
};

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
          }
        );
      });
    } else {
      res.json(callback1);
    }
  });
};

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
  });
}

exports.add_course = function (req, res) {
  let request = req.body;

  let obj = {
    course_name: request.course_name == undefined ? null : request.course_name,
    course_desc: request.course_desc == undefined ? null : request.course_desc,
    is_active: 1,
    is_delete: 0,
    created_by: request.admin_id == undefined ? null : request.admin_id,
    created_date: getCurrentDateTime()
  };

  common.insert(obj, "course", function (callback1) {
    res.json(callback1);
  });
};

exports.edit_course = function (req, res) {
  let request = req.body;

  let obj = {
    course_name: request.course_name,
    course_desc: request.course_desc,
    is_active: 1,
    is_delete: 0,
    modified_by: request.admin_id,
    modified_date: getCurrentDateTime()
  };

  common.update(
    obj,
    "course_id",
    request.course_id,
    "course",
    function (callback1) {
      res.json(callback1);
    }
  );
};

exports.delete_course = function (req, res) {
  let request = req.body;

  common.select_first(
    "select count(*) as count from subject where course_id = " +
      request.course_id,
    function (call) {
      console.log(call.result.count);
      let count = call.result.count;
      if (count > 0) {
        res.json({
          status: "error",
          code: "400",
          error: "First you have to delete all the subjects under the course."
        });
      } else {
        common.delete(
          "course_id",
          request.course_id,
          "course",
          function (callback1) {
            res.json(callback1);
          }
        );
      }
    }
  );
};

exports.get_all_subject = async function (req, res) {
  let course_id = req.query.course_id;
  let student_id = req.query.student_id;

  common.selectAll(
    "select * from subject where course_id = " + course_id,
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.add_subject = function (req, res) {
  let request = req.body.data;
  console.log("request");
  console.log(request);

  if (req.file) {
    console.log("file uploaded");
    request = JSON.parse(request);
    let obj = {
      course_id: request.course_id,
      subject_name: request.subject_name,
      subject_desc: request.subject_desc,
      note_name: request.note_name,
      note_url: "notes/" + req.file.originalname,
      is_active: 1,
      is_delete: 0,
      created_by: request.admin_id,
      created_date: getCurrentDateTime()
    };

    common.insert(obj, "subject", function (callback1) {
      res.json(callback1);
    });
  } else {
    res.json({
      code: "400",
      error: "File can not be uploaded"
    });
  }
};

exports.edit_subject = function (req, res) {
  let request = req.body;

  let note_path = request.note_path;
  console.log(req.file);

  if (req.file == undefined) {
  } else {
    request = req.body.data;
    request = JSON.parse(request);
    note_path = "notes/" + req.file.originalname;
  }

  let obj = {
    course_id: request.course_id,
    subject_name: request.subject_name,
    subject_desc: request.subject_desc,
    note_name: request.note_name,
    note_url: note_path,
    is_active: 1,
    is_delete: 0,
    modified_by: request.admin_id,
    modified_date: getCurrentDateTime()
  };

  common.update(
    obj,
    "subject_id",
    request.subject_id,
    "subject",
    function (callback1) {
      res.json(callback1);
    }
  );
};

exports.delete_subject = function (req, res) {
  let request = req.body;

  common.delete(
    "subject_id",
    request.subject_id,
    "subject",
    function (callback1) {
      res.json(callback1);
    }
  );
};

exports.add_note = async function (req, res) {
  let request = req.body.data;
  console.log("request");
  console.log(request);

  if (req.file) {
    console.log("file uploaded");
  }
  request = JSON.parse(request);
  let obj = {
    subject_id: request["subject_id"],
    note_name: request.note_name,
    note_path: "notes/" + req.file.originalname,
    note_desc: request.note_desc,
    note_extension: request.note_extension,
    is_active: 1,
    is_delete: 0,
    created_by: request.admin_id,
    created_date: getCurrentDateTime()
  };
  console.log(obj);

  common.insert(obj, "note", function (callback1) {
    console.log(callback1);
    res.json(callback1);
  });
};

exports.add_video = function (req, res) {
  let request = req.body.data;

  console.log(request);

  if (req.file) {
    console.log("file uploaded");
  }
  request = JSON.parse(request);

  let obj = {
    subject_id: request.subject_id,
    video_path:
      "videoes/" + req.file.originalname.split(" ").join("_").toLowerCase(),
    video_name: request.video_name,
    video_extension: request.video_extension,
    video_desc: request.video_desc,
    is_active: 1,
    is_delete: 0,
    created_by: request.admin_id,
    created_date: getCurrentDateTime()
  };

  console.log(obj);

  common.insert(obj, "video", function (callback1) {
    res.json(callback1);
  });
};

exports.edit_note = function (req, res) {
  let request = req.body;

  let note_path = request.note_path;
  console.log(req.file);

  if (req.file == undefined) {
  } else {
    request = req.body.data;
    request = JSON.parse(request);
    note_path = "notes/" + req.file.originalname;
  }

  let obj = {
    subject_id: request.subject_id,
    note_name: request.note_name,
    note_path: note_path,
    note_desc: request.note_desc,
    note_extension: request.note_extension,
    is_active: 1,
    is_delete: 0,
    modified_by: request.admin_id,
    modified_date: getCurrentDateTime()
  };

  console.log(obj);

  common.update(obj, "note_id", request.note_id, "note", function (callback1) {
    res.json(callback1);
  });
};

exports.delete_note = function (req, res) {
  let request = req.body;

  common.delete("note_id", request.note_id, "note", function (callback1) {
    res.json(callback1);
  });
};

exports.get_all_video = function (req, res) {
  let subject_id = req.query.subject_id;

  common.selectAll(
    "select * from video where subject_id = " + subject_id,
    function (call1) {
      console.log(call1);
      res.json(call1);
    }
  );
};

exports.edit_video = function (req, res) {
  let request = req.body;

  let video_path = request.video_path;
  console.log(req.file);

  if (req.file == undefined) {
  } else {
    request = req.body.data;
    request = JSON.parse(request);
    video_path =
      "videoes/" + req.file.originalname.split(" ").join("_").toLowerCase();
  }

  let obj = {
    subject_id: request.subject_id,
    video_path: video_path,
    video_name: request.video_name,
    video_extension: request.video_extension,
    video_desc: request.video_desc,
    is_active: 1,
    is_delete: 0,
    modified_by: request.admin_id,
    modified_date: getCurrentDateTime()
  };

  common.update(
    obj,
    "video_id",
    request.video_id,
    "video",
    function (callback1) {
      res.json(callback1);
    }
  );
};

exports.delete_video = function (req, res) {
  let request = req.body;

  common.delete("video_id", request.video_id, "video", function (callback1) {
    res.json(callback1);
  });
};

exports.delete_quiz = function (req, res) {
  let request = req.body;

  common.delete("quiz_id", request.quiz_id, "quiz", function (callback1) {
    res.json(callback1);
  });
};

exports.edit_quiz = function (req, res) {
  let request = req.body;
  let obj = {
    subject_id: request.subject_id,
    question: request.question,
    question_type: request.question_type,
    answer: request.answer,
    option1: request.option1,
    option2: request.option2,
    option3: request.option3,
    option4: request.option4,
    option5: request.option5,
    is_active: 1,
    is_delete: 0,
    modified_by: request.admin_id,
    modified_date: getCurrentDateTime()
  };

  common.update(obj, "quiz_id", request.quiz_id, "quiz", function (callback1) {
    res.json(callback1);
  });
};

exports.add_quiz = function (req, res) {
  let request = req.body;

  let obj = {
    subject_id: request.subject_id,
    question: request.question,
    question_type: request.question_type,
    answer: request.answer,
    option1: request.option1,
    option2: request.option2,
    option3: request.option3,
    option4: request.option4,
    option5: request.option5,
    is_active: 1,
    is_delete: 0,
    created_by: request.admin_id,
    created_date: getCurrentDateTime()
  };

  common.insert(obj, "quiz", function (callback1) {
    res.json(callback1);
  });
};

exports.add_multiple_quiz = function (req, res) {
  let items = req.body;
  console.log(items);
  var table_fields =
    "(subject_id,question,question_type,answer," +
    "option1,option2,option3,option4,option5," +
    "is_delete,is_active,created_by,created_date)";

  var object_array = [
    items.map((item) => [
      item.subject_id,
      item.question,
      item.question_type,
      item.answer,
      item.option1,
      item.option2,
      item.option3,
      item.option4,
      item.option5,
      0,
      1,
      item.admin_id,
      getCurrentDateTime()
    ])
  ];
  var table = "quiz";
  console.log(object_array);
  common.insert_multiple_rows(
    table_fields,
    object_array,
    table,
    function (callback1) {
      console.log(callback1);
      res.json(callback1);
    }
  );
};

exports.admin_login = function (req, res) {
  let data = req.body;
  console.log(data);

  common.selectAll(
    "select * from franchise where f_username = '" +
      data.admin_username +
      "' and f_password = '" +
      data.admin_password +
      "'",
    function (callback) {
      console.log(callback);
      res.json(callback);
    }
  );
};

exports.add_box_details = function (req, res) {
  let item = req.body;
  console.log(item);

  common.select_first("select * from hbt limit 1", function (call1) {
    if (call1.code == 200) {
      if (
        item.device_id != undefined &&
        call1.result.device_name != undefined
      ) {
        if (item.device_id == call1.result.device_name) {
          let obj = {
            f_id: item.f_id,
            box_id: item.device_id,
            f_name: item.f_name,
            f_phone: item.f_phone,
            f_email: item.f_email,
            f_address: item.f_address,
            f_state: item.f_state,
            f_city: item.f_city,
            f_token: item.f_token,
            f_username: item.f_username,
            f_password: item.f_password,
            is_active: 1,
            is_delete: 0,
            created_by: 1,
            created_date: getCurrentDateTime(),
            modified_by: 1,
            modified_date: getCurrentDateTime()
          };

          common.insert(obj, "franchise", function (call2) {
            res.json(call2);
          });
        } else {
          res.json({
            code: "400",
            status: "error",
            error: "Device does not match"
          });
        }
      } else {
        res.json({
          code: "400",
          status: "error",
          error: "Device id does not found"
        });
      }
    } else {
      res.json({
        code: "400",
        status: "error",
        error:
          "This box does not having data for checking temperature and cpu usage. Please connect to the admin for verify."
      });
    }
  });
};
