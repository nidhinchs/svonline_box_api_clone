const fs = require("fs");
let box_common = require("./common");
let common = require("./admin_common");
const async = require("async");
const path = require("path");

const course_table = "course";

const subject_table = "subject";
const video_table = "video";
const notes_table = "note";
const quiz_table = "quiz";

const filename = "course_data.sql";

let video_urls = [];
let note_urls = [];

const { v4: uuidv4 } = require("uuid");

exports.get_courses = function (req, res) {
  let query = "select * from course";

  common.selectAll(query, function (call1) {
    res.json(call1);
  });
};

exports.add_course_to_box_from_server = function (req, res) {
  let item = req.query;

  video_urls = [];
  note_urls = [];

  const courseId = item.course_id;
  if (courseId != undefined) {
    let query = "";
    const sqlStream = fs.createWriteStream(filename);

    getCoursesInsertQuery(courseId, function (call1) {
      if (call1.code == 200) {
        query += call1.result + "\n";
        // sqlStream.write(call1.result + "\n");

        getSubjectsInsertQuery(courseId, function (call2) {
          if (call2.code == 200) {
            // console.log(call2);
            query += call2.result;
            // sqlStream.write(call2.result);

            // sqlStream.end();
            fs.writeFileSync(filename, query);

            readFileAndAddToBox(function (call3) {
              res.json(call3);
            });
          } else {
            // sqlStream.end();
            fs.writeFileSync(filename, query);

            readFileAndAddToBox(function (call3) {
              res.json(call3);
            });
          }
        });
      } else {
        res.json(call1);
      }
    });
  } else {
    res.json({
      code: "400",
      error: "Please give me course Id.",
      status: "error"
    });
  }
};

function getCoursesInsertQuery(courseId, callback) {
  if (courseId != undefined) {
    const sqlStream = fs.createWriteStream("course_data.sql");

    const selectCourseQuery = `SELECT * FROM course WHERE course_id = ${courseId}`;

    common.select_first(selectCourseQuery, function (courseResult) {
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
    });
  }
}

function getSubjectsInsertQuery(courseId, callback) {
  const selectSubjectsQuery = `SELECT * FROM ${subject_table} WHERE course_id = ${courseId}`;
  common.selectAll(selectSubjectsQuery, function (result) {
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
  });
}

function getVideoInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    const selectVideosQuery = `SELECT * FROM ${video_table} WHERE subject_id = ${subject.subject_id}`;
    common.selectAll(selectVideosQuery, function (videoResult) {
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
    });
  });
}

function getNotesInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    const selectVideosQuery = `SELECT * FROM ${notes_table} WHERE subject_id = ${subject.subject_id}`;
    common.selectAll(selectVideosQuery, function (videoResult) {
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
    });
  });
}

function getQuizInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    const selectVideosQuery = `SELECT * FROM ${quiz_table} WHERE subject_id = ${subject.subject_id}`;
    common.selectAll(selectVideosQuery, function (videoResult) {
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
  async.eachSeries(queries, (query, next) => {
    box_common.execute_query(query, function (call1) {
      console.log(call1);
      if (queries[queries.length - 1] == query) {
        download_files();
        callback({
          code: "200",
          status: "success",
          result: {
            video_urls: video_urls,
            note_urls: note_urls
          }
        });
      } else {
        next();
      }
    });
  });
}
