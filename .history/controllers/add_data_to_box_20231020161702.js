const fs = require("fs");
let box_common = require("./common");
// let common = require("./admin_common");
const async = require("async");
const path = require("path");

const axios = require("axios");

const course_table = "course";

const subject_table = "subject";
const video_table = "video";
const notes_table = "note";
const quiz_table = "quiz";

const filename = "course_data.sql";
const temp = require("./temperature");

let video_urls = [];
let note_urls = [];
let update_id = 0;

let baseurl = "http://64.227.184.42:3003/api/";
let course_url = "get_course_by_course_id?course_id=";
let subject_url = "get_course_by_course_id?course_id=";
let video_url = "get_course_by_course_id?subject_id=";
let note_url = "get_course_by_course_id?subject_id=";
let quiz_url = "get_course_by_course_id?subject_id=";

const { v4: uuidv4 } = require("uuid");

exports.download_old_course = function (req, res) {
  box_common.selectAll(
    "select * from course_update_log where status=0",
    function (call2) {
      if (call2.code == 200) {
        temp.disable_access_point1(req, res);
      } else {
        res.json({
          code: "400",
          status: "error",
          error: "No courses are remaining to download."
        });
      }
    }
  );
};

exports.download_course_with_course_id = function (req, res) {
  let id = req.query.course_id;

  box_common.selectAll(
    "select * from course_update_log where status=0",
    function (call2) {
      if (call2.code == 200) {
        res.json({
          code: "600",
          status: "error",
          error:
            "There is one course downloading Request is pending. first complete it."
        });
      } else {
        let item = {
          course_id: id
        };

        box_common.insert(item, "course_update_log", function (call1) {
          if (call1.code == 200) {
            temp.disable_access_point1(req, res);
            // res.json(call1);
          } else {
            res.json(call1);
          }
        });
      }
    }
  );
};

// exports.get_courses = function (req, res) {
//   let query = "select * from course";

//   common.selectAll(query, function (call1) {
//     res.json(call1);
//   });
// };

exports.add_course_to_box_from_server = function (callback) {
  // let item = req.query;

  video_urls = [];
  note_urls = [];
  update_id = 0;

  box_common.select_first(
    "select * from course_update_log where status = 0 order by created_date desc",
    function (call1) {
      if (call1.code == 200) {
        const courseId = call1.result.course_id;
        update_id = call1.result.update_id;

        console.log(update_id);

        if (courseId != undefined) {
          let query = "";
          const sqlStream = fs.createWriteStream(filename);

          getCoursesInsertQuery(courseId, function (call4) {
            if (call4.code == 200) {
              query += call4.result + "\n";
              // sqlStream.write(call1.result + "\n");

              getSubjectsInsertQuery(courseId, function (call2) {
                if (call2.code == 200) {
                  query += call2.result;
                  fs.writeFileSync(filename, query);
                  readFileAndAddToBox(function (call3) {
                    // callback(call3);
                  });
                } else {
                  fs.writeFileSync(filename, query);
                  readFileAndAddToBox(function (call3) {
                    // callback(call3);
                  });
                }
              });
            } else {
              // callback(call4);
            }
          });
        } else {
          console.log({
            code: "400",
            error: "Please give me course Id.",
            status: "error"
          });
          // callback({
          //   code: "400",
          //   error: "Please give me course Id.",
          //   status: "error"
          // });
        }
      } else {
        // callback(call1);
      }
    }
  );
};

// exports.add_course_to_box_from_server = function (req, res) {
//   let item = req.query;

//   video_urls = [];
//   note_urls = [];
//   update_id = 0;

//   box_common.select_first(
//     "select * from course_update_log where status = 0 order by created_date desc",
//     function (call1) {
//       if (call1.code == 200) {
//         const courseId = call1.result.course_id;
//         update_id = call1.result.update_id;

//         if (courseId != undefined) {
//           let query = "";
//           const sqlStream = fs.createWriteStream(filename);

//           getCoursesInsertQuery(courseId, function (call1) {
//             if (call1.code == 200) {
//               query += call1.result + "\n";
//               // sqlStream.write(call1.result + "\n");

//               getSubjectsInsertQuery(courseId, function (call2) {
//                 if (call2.code == 200) {
//                   query += call2.result;
//                   fs.writeFileSync(filename, query);
//                   readFileAndAddToBox(function (call3) {
//                     res.json(call3);
//                   });
//                 } else {
//                   fs.writeFileSync(filename, query);
//                   readFileAndAddToBox(function (call3) {
//                     res.json(call3);
//                   });
//                 }
//               });
//             } else {
//               res.json(call1);
//             }
//           });
//         } else {
//           res.json({
//             code: "400",
//             error: "Please give me course Id.",
//             status: "error"
//           });
//         }
//       } else {
//         res.json(call1);
//       }
//     }
//   );
// };

function getCoursesInsertQuery(courseId, callback) {
  if (courseId != undefined) {
    const sqlStream = fs.createWriteStream("course_data.sql");

    console.log(baseurl + course_url + courseId);

    axios
      .get(baseurl + course_url + courseId)
      .then(function (response) {
        let courseResult = response.data;
        console.log(courseResult);
        // Handle the successful response here
        if (courseResult.code == 200) {
          const course = courseResult.result;

          // Generate insert query for the course
          const courseColumns = Object.keys(course).join(",");
          const courseValues = Object.values(course)
            .map((value) => (value === null ? "NULL" : `'${value}'`))
            .join(",");
          const courseInsertQuery =
            `INSERT INTO course (${courseColumns}) VALUES (${courseValues});` +
            "\n";

          callback({
            code: "200",
            status: "success",
            result: courseInsertQuery
          });
        } else {
          callback({
            code: "400",
            error: `Failed to fetch ${course_table}:` + courseResult.error,
            status: "error"
          });
          console.log(`Failed to fetch ${course_table}:`, courseResult.error);
        }
        // console.log('Response data:', response.data);
      })
      .catch(function (error) {
        callback({
          code: "400",
          error: `Failed to fetch course:`,
          status: "error"
        });
        // Handle any errors that occurred during the request
        console.error("Error:", error);
      });
  }
}

function getSubjectsInsertQuery(courseId, callback) {
  console.log(baseurl + subject_url + courseId);
  axios
    .get(baseurl + subject_url + courseId)
    .then(function (response) {
      if (result.code == 200) {
        const subjects = result.result;

        let insertQueries = subjects
          .map((subject) => {
            const videoFileName = path.basename(subject.note_url);

            if (videoFileName != "") {
              note_urls.push(subject.note_url);
              subject.note_url = `notes/${videoFileName}`;
            }

            const columns = Object.keys(subject).join(",");
            const values = Object.values(subject)
              .map((value) => (value === null ? "NULL" : `'${value}'`))
              .join(",");
            return `INSERT INTO ${subject_table} (${columns}) VALUES (${values});`;
          })
          .join("\n");

        console.log(insertQueries);

        getVideoInsertQuery(subjects, function (call1) {
          if (call1.code == 200) {
            insertQueries += call1.result;
          }
          getNotesInsertQuery(subjects, function (call2) {
            if (call2.code == 200) {
              insertQueries += call2.result;
            }

            getQuizInsertQuery(subjects, function (call3) {
              if (call3.code == 200) {
                insertQueries += call3.result;
              }
              callback({
                code: "200",
                status: "success",
                result: insertQueries
              });
            });
          });
        });

        //   callback({
        //     code: "200",
        //     status: "success",
        //     result: insertQueries
        //   });
      } else {
        callback({
          code: "400",
          error: `Failed to fetch ${subject_table}:` + result.error,
          status: "error"
        });
      }
    })
    .catch(function (error) {
      // Handle any errors that occurred during the request
      console.error("Error:", error);
    });
}

function getVideoInsertQuery(subjects, callback) {
  async.eachSeries(subjects, (subject, next) => {
    axios
      .get(baseurl + video_url + subject.subject_id)
      .then(function (videoResult) {
        if (videoResult.code == 200) {
          let videoQueries = videoResult.result
            .map((video) => {
              const videoFileName = path.basename(video.video_path);

              if (videoFileName != "") {
                video_urls.push(video.video_path);
                video.video_path = `videoes/${videoFileName}`;
              }
              const video_columns = Object.keys(video).join(",");
              const video_values = Object.values(video)
                .map((value) => (value === null ? "NULL" : `'${value}'`))
                .join(",");
              return (
                `INSERT INTO ${video_table} (${video_columns}) VALUES (${video_values});` +
                "\n"
              );
            })
            .join("\n");
          console.log("*********** video queries ***********************//");
          console.log(videoQueries);
          query += videoQueries;
          console.log(subject.subject_id);
          console.log(subjects[subjects.length - 1].subject_id);
        }

        if (subject.subject_id == subjects[subjects.length - 1].subject_id) {
          console.log("******************query***************************");
          console.log(query);
          callback({
            code: "200",
            status: "success",
            result: query
          });
        } else {
          next();
        }
      })
      .catch(function (error) {
        // Handle any errors that occurred during the request
        console.error("Error:", error);
      });
  });
}

function getNotesInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    axios
      .get(baseurl + note_url + subject.subject_id)
      .then(function (videoResult) {
        if (videoResult.code == 200) {
          let videoQueries = videoResult.result
            .map((video) => {
              const videoFileName = path.basename(video.note_path);
              console.log(videoFileName);

              if (videoFileName != "") {
                note_urls.push(video.note_path);
                video.note_path = `notes/${videoFileName}`;
              }

              const video_columns = Object.keys(video).join(",");
              const video_values = Object.values(video)
                .map((value) => (value === null ? "NULL" : `'${value}'`))
                .join(",");
              return (
                `INSERT INTO ${notes_table} (${video_columns}) VALUES (${video_values});` +
                "\n"
              );
            })
            .join("\n");
          console.log("*********** video queries ***********************//");
          console.log(videoQueries);
          query += videoQueries;
          console.log(subject.subject_id);
          console.log(subjects[subjects.length - 1].subject_id);
        }

        if (subject.subject_id == subjects[subjects.length - 1].subject_id) {
          console.log("******************query***************************");
          console.log(query);
          callback({
            code: "200",
            status: "success",
            result: query
          });
        } else {
          next();
        }
      })
      .catch(function (error) {
        // Handle any errors that occurred during the request
        console.error("Error:", error);
      });
  });
}

function getQuizInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    axios
      .get(baseurl + quiz_url + subject.subject_id)
      .then(function (videoResult) {
        if (videoResult.code == 200) {
          let videoQueries = videoResult.result
            .map((video) => {
              const video_columns = Object.keys(video).join(",");
              const video_values = Object.values(video)
                .map((value) => (value === null ? "NULL" : `'${value}'`))
                .join(",");
              return (
                `INSERT INTO ${quiz_table} (${video_columns}) VALUES (${video_values});` +
                "\n"
              );
            })
            .join("\n");
          console.log("*********** video queries ***********************//");
          console.log(videoQueries);
          query += videoQueries;
          console.log(subject.subject_id);
          console.log(subjects[subjects.length - 1].subject_id);
        }

        if (subject.subject_id == subjects[subjects.length - 1].subject_id) {
          console.log("******************query***************************");
          console.log(query);
          callback({
            code: "200",
            status: "success",
            result: query
          });
        } else {
          next();
        }
      })
      .catch(function (error) {
        // Handle any errors that occurred during the request
        console.error("Error:", error);
      });
  });
}

function readFileAndAddToBox(callback) {
  const generatedSql = fs.readFileSync(filename, "utf8");

  fs.readFile(filename, "utf8", (readError, generatedSql) => {
    if (readError) {
      console.error("Error reading SQL file:", readError);
      return;
    }

    // Split the SQL script into individual queries
    const insertQueries = generatedSql
      .split(";")
      .filter((query) => query.trim() !== "");

    // Execute insert queries sequentially
    executeInsertQueriesSequentially(insertQueries, function (call1) {
      callback(call1);
    });
  });
}

function executeInsertQueriesSequentially(queries, callback) {
  const sqlstring = require("sqlstring");
  async.eachSeries(queries, (query, next) => {
    const correctedQuery = sqlstring.format(query);

    // console.log(query);
    box_common.execute_query(correctedQuery, async function (call1) {
      console.log(call1);
      if (queries[queries.length - 1] == query) {
        if (video_urls.length > 0) {
          await downloadFiles(function (call1) {
            callback(call1);
          });
        } else {
          if (note_urls.length > 0) {
            downloadNoteFiles(function (call1) {
              callback(call1);
            });
          } else {
            update_log_status(function (call2) {
              callback(call2);
            });
          }
        }
      } else {
        next();
      }
    });
  });
}

async function downloadFiles(callback) {
  async.eachSeries(video_urls, (url, next) => {
    new Promise((resolve, reject) => {
      const https = require("https");
      let downloadFolderPath = "./public/videoes/";
      console.log("url------------------>");
      console.log(url);

      const splitUrl = url.split("/");
      const filename = splitUrl[splitUrl.length - 1];

      const outputPath = `${downloadFolderPath}${filename}`;

      console.log(outputPath);

      if (!fs.existsSync(`${downloadFolderPath}`)) {
        fs.mkdirSync(`${downloadFolderPath}`, {
          recursive: true
        });
      }

      const options = {
        hostname: splitUrl[2], // Extract the hostname from the URL
        path: `/${splitUrl.slice(3).join("/")}`, // Extract the path from the URL
        followRedirects: true // Handle HTTP redirects
      };

      const file = fs.createWriteStream(outputPath);

      const request = https.get(options, (res) => {
        if (res.statusCode === 200) {
          console.log("get success");
          res.pipe(file);
          // res.pipe(file).on("close", resolve);

          file.on("finish", () => {
            file.close(() => {
              console.log(`Downloaded: ${filename}`);
              resolve(); // Resolve the promise when download is complete
              if (video_urls[video_urls.length - 1] == url) {
                console.log("finish videoes");
                if (note_urls.length > 0) {
                  downloadNoteFiles(function (call1) {
                    callback(call1);
                  });
                } else {
                  update_log_status(function (call2) {
                    callback(call2);
                  });
                }
              } else {
                console.log("next");
                next();
              }
            });
          });
        } else {
          reject(res.statusCode);
          callback({
            status: res.statusCode.toString(),
            code: "400",
            error: "there is some download error"
          });
          console.log("get error" + res.statusCode);
        }
      });
      request.on("error", (error) => {
        reject(`Download Error: ${error}`);
      });
    });
  });
}

function update_log_status(callback) {
  console.log("update_log_status");
  let obj = {
    status: 1
  };
  box_common.update(
    obj,
    "update_id",
    update_id,
    "course_update_log",
    function (call1) {
      if (call1.code == 200) {
        temp.enable_access_point(function (call2) {
          callback(call2);
        });
      } else {
        callback(call1);
      }
    }
  );
}

function downloadNoteFiles(callback) {
  async.eachSeries(note_urls, (url, next) => {
    new Promise((resolve, reject) => {
      const https = require("https");
      let downloadFolderPath = "./public/notes/";
      console.log("url------------------>");
      console.log(url);

      const splitUrl = url.split("/");
      const filename = splitUrl[splitUrl.length - 1];

      const outputPath = `${downloadFolderPath}${filename}`;

      console.log(outputPath);

      if (!fs.existsSync(`${downloadFolderPath}`)) {
        fs.mkdirSync(`${downloadFolderPath}`, {
          recursive: true
        });
      }

      const options = {
        hostname: splitUrl[2], // Extract the hostname from the URL
        path: `/${splitUrl.slice(3).join("/")}`, // Extract the path from the URL
        followRedirects: true // Handle HTTP redirects
      };
      const file = fs.createWriteStream(outputPath);
      try {
        const request = https.get(options, (res) => {
          res.pipe(file);
          file.on("finish", () => {
            file.close(() => {
              console.log(`Downloaded: ${filename}`);
              resolve(); // Resolve the promise when download is complete
              if (res.statusCode === 200) {
                console.log("get success");
                res.pipe(file).on("close", resolve);

                if (note_urls[note_urls.length - 1] == url) {
                  update_log_status(function (call3) {
                    callback(call3);
                  });
                } else {
                  next();
                }
              } else {
                // reject(res.statusCode);
                callback({
                  status: res.statusCode.toString(),
                  code: "400",
                  error: "there is some download error"
                });
                console.log("get error" + res.statusCode);
              }
            });
          });
        });

        request.on("error", (error) => {
          reject(`Download Error: ${error}`);
        });
      } catch (e) {
        console.log(e);
        callback({
          status: "error",
          code: "400",
          error: e.code
        });
      }
    });
  });
}
