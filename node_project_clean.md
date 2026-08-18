# svonline - Clean Version

> Generated automatically. Includes only config/, controllers/, routes/, main files, and one SQL file.

## 🧩 Project Summary
**Description:** 

**Version:** 1.0.0

**Main File:** index.js

### 📦 Dependencies
- @google-cloud/compute: ^3.3.0
- async: ^3.2.4
- axios: ^1.4.0
- cookie-parser: ~1.4.4
- cors: ^2.8.5
- debug: ~2.6.9
- express: ^4.16.4
- express-fileupload: ^1.4.0
- fcm-node: ^1.3.0
- firebase: ^9.8.3
- firebase-admin: ^11.0.0
- google-distance: ^0.0.7
- http-errors: ~1.6.3
- moment-timezone: ^0.5.28
- morgan: ~1.9.1
- multer: ^1.4.5-lts.1
- mysql: ^2.18.1
- mysql-events: ^0.0.1
- node-cron: ^3.0.1
- nodemon: ^1.3.3
- pug: ^3.0.2
- sha1: ^1.1.1
- sqlstring: ^2.3.3
- twilio: ^3.40.0

### 🧰 Dev Dependencies
- pkg: ^4.4.9

---
## 📁 Included Files
- config\admin_db.js
- config\config.js
- config\db.js
- controllers\add_data_to_box.js
- controllers\add_data_to_box1.js
- controllers\admin_common.js
- controllers\commands.js
- controllers\common.js
- controllers\copyFile.js
- controllers\DbController.js
- controllers\db_update.js
- controllers\download_file.js
- controllers\item.js
- controllers\log.js
- controllers\quiz.js
- controllers\student.js
- controllers\syncData.js
- controllers\temperature.js
- controllers\upload.js
- controllers\video.js
- controllers\video_upload.js
- routes\index.js
- routes\sync_data.js
- index.js
- course_data.sql (Database File)

---

## File: package.json

```json
{
  "name": "svonline",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "start": "node index.js"
  },
  "bin": {
    "execute": "index.js"
  },
  "dependencies": {
    "@google-cloud/compute": "^3.3.0",
    "async": "^3.2.4",
    "axios": "^1.4.0",
    "cookie-parser": "~1.4.4",
    "cors": "^2.8.5",
    "debug": "~2.6.9",
    "express": "^4.16.4",
    "express-fileupload": "^1.4.0",
    "fcm-node": "^1.3.0",
    "firebase": "^9.8.3",
    "firebase-admin": "^11.0.0",
    "google-distance": "^0.0.7",
    "http-errors": "~1.6.3",
    "moment-timezone": "^0.5.28",
    "morgan": "~1.9.1",
    "multer": "^1.4.5-lts.1",
    "mysql": "^2.18.1",
    "mysql-events": "^0.0.1",
    "node-cron": "^3.0.1",
    "nodemon": "^1.3.3",
    "pug": "^3.0.2",
    "sha1": "^1.1.1",
    "sqlstring": "^2.3.3",
    "twilio": "^3.40.0"
  },
  "devDependencies": {
    "pkg": "^4.4.9"
  }
}

```

## File: config\admin_db.js

```javascript
var mysql = require("mysql");
let config = require("./config").config();

var pool = mysql.createPool({
  connectionLimit: 100, 
  host: config.export_db.host,
  port: "25060",
  user: config.export_db.username,
  password: config.export_db.password,
  database: config.export_db.database,
  debug: false,
  multipleStatements: true,
  timezone: "Asia/Kolkata"
});

module.exports = pool;
```

## File: config\config.js

```javascript
var env = require("../config/config.json");

exports.config = function () {
  var node_env = "test";
  
  
  
  return env[node_env];
};
```

## File: config\db.js

```javascript
var mysql = require("mysql");
let config = require("./config").config();

var pool = mysql.createPool({
  connectionLimit: 100, 
  host: config.import_db.host,
  port: "3306",
  user: config.import_db.username,
  password: config.import_db.password,
  database: config.import_db.database,
  debug: false,
  multipleStatements: true,
  timezone: "Asia/Kolkata"
});

module.exports = pool;
```

## File: controllers\add_data_to_box.js

```javascript
const fs = require("fs");
let box_common = require("./common");

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

let baseurl = "http:
let course_url = "get_course_by_course_id?course_id=";
let subject_url = "get_subjects_by_course_id?course_id=";
let video_url = "get_video_by_subject_id?subject_id=";
let note_url = "get_note_by_subject_id?subject_id=";
let quiz_url = "get_quiz_by_subject_id?subject_id=";

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
            
          } else {
            res.json(call1);
          }
        });
      }
    }
  );
};









exports.add_course_to_box_from_server = function (callback) {
  

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
              

              getSubjectsInsertQuery(courseId, function (call2) {
                if (call2.code == 200) {
                  query += call2.result;
                  fs.writeFileSync(filename, query);
                  readFileAndAddToBox(function (call3) {
                    
                  });
                } else {
                  fs.writeFileSync(filename, query);
                  readFileAndAddToBox(function (call3) {
                    
                  });
                }
              });
            } else {
              
            }
          });
        } else {
          console.log({
            code: "400",
            error: "Please give me course Id.",
            status: "error"
          });
          
          
          
          
          
        }
      } else {
        
      }
    }
  );
};
























































function getCoursesInsertQuery(courseId, callback) {
  if (courseId != undefined) {
    const sqlStream = fs.createWriteStream("course_data.sql");

    console.log(baseurl + course_url + courseId);

    axios
      .get(baseurl + course_url + courseId)
      .then(function (response) {
        let courseResult = response.data;
        console.log(courseResult);
        
        if (courseResult.code == 200) {
          const course = courseResult.result;

          
          const courseColumns = Object.keys(course).join(",");
          const courseValues = Object.values(course)
            .map((value) => (value === null ? "NULL" : `'${value}'`))
            .join(",");
          const courseInsertQuery =
            `INSERT INTO course (${courseColumns}) VALUES (${courseValues});` +
            "\n";

          console.log(courseInsertQuery);

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
        
      })
      .catch(function (error) {
        callback({
          code: "400",
          error: `Failed to fetch course:`,
          status: "error"
        });
        
        console.error("Error:", error);
      });
  }
}

function getSubjectsInsertQuery(courseId, callback) {
  console.log(baseurl + subject_url + courseId);
  axios
    .get(baseurl + subject_url + courseId)
    .then(function (response) {
      let result = response.data;
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

        
        
        
        
        
      } else {
        callback({
          code: "400",
          error: `Failed to fetch ${subject_table}:` + result.error,
          status: "error"
        });
      }
    })
    .catch(function (error) {
      
      console.error("Error:", error);
    });
}

function getVideoInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    axios
      .get(baseurl + video_url + subject.subject_id)
      .then(function (response) {
        let videoResult = response.data;
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
          console.log("*********** video queries ***********************
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
        
        console.error("Error:", error);
      });
  });
}

function getNotesInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    axios
      .get(baseurl + note_url + subject.subject_id)
      .then(function (response) {
        let videoResult = response.data;
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
          console.log("*********** video queries ***********************
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
        
        console.error("Error:", error);
      });
  });
}

function getQuizInsertQuery(subjects, callback) {
  let query = "";
  async.eachSeries(subjects, (subject, next) => {
    axios
      .get(baseurl + quiz_url + subject.subject_id)
      .then(function (response) {
        let videoResult = response.data;
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
          console.log("*********** video queries ***********************
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

    
    const insertQueries = generatedSql
      .split(";")
      .filter((query) => query.trim() !== "");

    
    executeInsertQueriesSequentially(insertQueries, function (call1) {
      callback(call1);
    });
  });
}

function executeInsertQueriesSequentially(queries, callback) {
  const sqlstring = require("sqlstring");
  async.eachSeries(queries, (query, next) => {
    const correctedQuery = sqlstring.format(query);

    
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
        hostname: splitUrl[2], 
        path: `/${splitUrl.slice(3).join("/")}`, 
        followRedirects: true 
      };

      const file = fs.createWriteStream(outputPath);

      const request = https.get(options, (res) => {
        if (res.statusCode === 200) {
          console.log("get success");
          res.pipe(file);
          

          file.on("finish", () => {
            file.close(() => {
              console.log(`Downloaded: ${filename}`);
              resolve(); 
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
        hostname: splitUrl[2], 
        path: `/${splitUrl.slice(3).join("/")}`, 
        followRedirects: true 
      };
      const file = fs.createWriteStream(outputPath);
      try {
        const request = https.get(options, (res) => {
          res.pipe(file);
          file.on("finish", () => {
            file.close(() => {
              console.log(`Downloaded: ${filename}`);
              resolve(); 
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
```

## File: controllers\add_data_to_box1.js

```javascript
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
const temp = require("./temperature");

let video_urls = [];
let note_urls = [];
let update_id = 0;

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
            
          } else {
            res.json(call1);
          }
        });
      }
    }
  );
};

exports.get_courses = function (req, res) {
  let query = "select * from course";

  common.selectAll(query, function (call1) {
    res.json(call1);
  });
};

exports.add_course_to_box_from_server = function (callback) {
  

  video_urls = [];
  note_urls = [];
  update_id = 0;

  box_common.select_first(
    "select * from course_update_log where status = 0 order by created_date desc",
    function (call1) {
      if (call1.code == 200) {
        const courseId = call1.result.course_id;
        update_id = call1.result.update_id;

        if (courseId != undefined) {
          let query = "";
          const sqlStream = fs.createWriteStream(filename);

          getCoursesInsertQuery(courseId, function (call1) {
            if (call1.code == 200) {
              query += call1.result + "\n";
              

              getSubjectsInsertQuery(courseId, function (call2) {
                if (call2.code == 200) {
                  query += call2.result;
                  fs.writeFileSync(filename, query);
                  readFileAndAddToBox(function (call3) {
                    callback(call3);
                  });
                } else {
                  fs.writeFileSync(filename, query);
                  readFileAndAddToBox(function (call3) {
                    callback(call3);
                  });
                }
              });
            } else {
              callback(call1);
            }
          });
        } else {
          callback({
            code: "400",
            error: "Please give me course Id.",
            status: "error"
          });
        }
      } else {
        callback(call1);
      }
    }
  );
};
























































function getCoursesInsertQuery(courseId, callback) {
  if (courseId != undefined) {
    const sqlStream = fs.createWriteStream("course_data.sql");

    const selectCourseQuery = `SELECT * FROM course WHERE course_id = ${courseId}`;

    common.select_first(selectCourseQuery, function (courseResult) {
      if (courseResult.code == 200) {
        const course = courseResult.result;

        
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
        console.log("*********** video queries ***********************
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
        console.log("*********** video queries ***********************
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
        console.log("*********** video queries ***********************
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

    
    const insertQueries = generatedSql
      .split(";")
      .filter((query) => query.trim() !== "");

    
    executeInsertQueriesSequentially(insertQueries, function (call1) {
      callback(call1);
    });
  });
}

function executeInsertQueriesSequentially(queries, callback) {
  const sqlstring = require("sqlstring");
  async.eachSeries(queries, (query, next) => {
    const correctedQuery = sqlstring.format(query);

    
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
        hostname: splitUrl[2], 
        path: `/${splitUrl.slice(3).join("/")}`, 
        followRedirects: true 
      };

      const file = fs.createWriteStream(outputPath);

      const request = https.get(options, (res) => {
        if (res.statusCode === 200) {
          console.log("get success");
          res.pipe(file);
          

          file.on("finish", () => {
            file.close(() => {
              console.log(`Downloaded: ${filename}`);
              resolve(); 
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
        hostname: splitUrl[2], 
        path: `/${splitUrl.slice(3).join("/")}`, 
        followRedirects: true 
      };
      const file = fs.createWriteStream(outputPath);
      try {
        const request = https.get(options, (res) => {
          res.pipe(file);
          file.on("finish", () => {
            file.close(() => {
              console.log(`Downloaded: ${filename}`);
              resolve(); 
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
```

## File: controllers\admin_common.js

```javascript
let connection = require("../config/admin_db");
let moment = require("moment-timezone");

global.getCurrentDateTime = function () {
  return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
};

exports.insert = function (object, table, callback) {
  
  
  
  let query = "INSERT INTO " + table + " SET ?";
  connection.query(
    "INSERT INTO " + table + " SET ?",
    object,
    function (error, results, fields) {
      console.log(query);
      if (error) {
        callback({ status: "fail", code: ERROR, error: error.message });
        console.log(callback);
      } else {
        callback({
          status: "success",
          code: SUCCESS,
          cust_id: results.insertId
        });
        console.log(callback);
      }
    }
  );
};

exports.update = function (object, unique_id_name, unique_id, table, callback) {
  
  
  
  let query = "UPDATE " + table + " SET ? WHERE " + unique_id_name + " =?";
  connection.query(
    query,
    [object, unique_id],
    function (error, results, fields) {
      console.log(query);
      if (error) {
        callback({ status: "fail", code: ERROR, error: error.message });
        console.log(callback);
      } else {
        callback({ status: "success", code: SUCCESS });
        console.log(callback);
      }
    }
  );
};

exports.delete = function (unique_id_name, unique_id, table, callback) {
  
  
  
  let query = "DELETE FROM " + table + " WHERE " + unique_id_name + " =?";
  connection.query(query, [unique_id], function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({ status: "success", code: SUCCESS });
      console.log(callback);
    }
  });
};
exports.delete_direct = function (query, callback) {
  
  
  

  connection.query(query, function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({ status: "success", code: SUCCESS });
      console.log(callback);
    }
  });
};

exports.select_first = function (query, callback) {
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      console.log(error);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      if (results.length == 0) {
        callback({ status: "fail", code: ERROR_EMPTY, error: "No Data Found" });
      } else {
        callback({ status: "success", code: SUCCESS, result: results[0] });
      }
    }
  });
};

exports.selectAll = function (query, callback) {
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      if (results.length == 0) {
        callback({ status: "fail", code: ERROR_EMPTY, error: "No Data Found" });
      } else {
        callback({ status: "success", code: SUCCESS, result: results });
      }
    }
  });
};

exports.execute_query = function (query, callback) {
  console.log(query);
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      callback({ status: "success", code: SUCCESS });
    }
  });
};
```

## File: controllers\commands.js

```javascript
const fs = require("fs");
const wpaConfigPath = "/etc/wpa_supplicant/wpa_supplicant.conf";
const { exec } = require("child_process");

const temp = require("../controllers/temperature");

exports.add_wifi_cred = function (req, res) {
  const wifiCredentials = req.body;

  console.log(wifiCredentials);

  const wifiSSID = wifiCredentials.ssid;
  const wifiPassword = wifiCredentials.password;

  exec(`sudo chmod 644 ${wpaConfigPath}`, (error, stdout, stderr) => {
    if (error) {
      res.json({
        code: "400",
        status: "error",
        error: "Error writing wpa_supplicant configuration"
      });
      console.error("Error giving write permissions to the file:", error);
    } else {
      console.log("Write permissions granted to the file.");

      
      if (fs.existsSync(wpaConfigPath)) {
        console.log("wpa_supplicant configuration file exists. Rewriting...");
      }

      
      const wpaSupplicantConfig = `
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=IN

network={
    ssid="${wifiSSID}"
    psk="${wifiPassword}"
}
`;

      
      fs.writeFile(wpaConfigPath, wpaSupplicantConfig, (err) => {
        if (err) {
          console.error("Error writing wpa_supplicant configuration:", err);
          res.json({
            code: "400",
            status: "error",
            error: "Error writing wpa_supplicant configuration"
          });
        } else {
          

          const { exec } = require("child_process");
          temp.disable_access_point1(req, res);
          
          
          
          
          
          
          
        }
      });
    }
  });
};

exports.shut_down = function (req, res) {
  exec(`sudo shutdown -r now`, (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    console.log(`stderr: ${stderr}`);
    res.json({ code: "200", status: "success" });
  });
};

exports.reboot = function (req, res) {
  
  
  
  
  
  
  
  
  

  const { spawn } = require("child_process");

  
  const pythonScriptPath = "../Public/Networks/connect.py";

  
  const pythonProcess = spawn("python", [pythonScriptPath]);

  
  pythonProcess.stdout.on("data", (data) => {
    console.log(`Python stdout: ${data}`);
    res.json({
      code: "200",
      status: "success",
      result: `Python stdout: ${data}`
    });
  });

  pythonProcess.stderr.on("data", (data) => {
    res.json({
      code: "400",
      status: "error",
      error: `Python stderr: ${data}`
    });
    console.error(`Python stderr: ${data}`);
  });

  
  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);
  });
};
```

## File: controllers\common.js

```javascript
let connection = require("../config/db");
global.ERROR = "400";
global.SUCCESS = "200";
global.ERROR_EMPTY = "500";
const log = require("./log");
var mysql = require("mysql");

let moment = require("moment-timezone");

global.getCurrentDateTime = function () {
  return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
};

exports.insert = function (object, table, callback) {
  
  
  
  let query = "INSERT INTO " + table + " SET ?";
  connection.query(
    "INSERT INTO " + table + " SET ?",
    object,
    function (error, results, fields) {
      console.log(query);
      if (error) {
        callback({ status: "fail", code: ERROR, error: error.message });
        console.log(callback);
      } else {
        callback({
          status: "success",
          code: SUCCESS,
          cust_id: results.insertId
        });
        console.log(callback);
      }
    }
  );
};

exports.update = function (object, unique_id_name, unique_id, table, callback) {
  
  
  
  let query = "UPDATE " + table + " SET ? WHERE " + unique_id_name + " =?";
  connection.query(
    query,
    [object, unique_id],
    function (error, results, fields) {
      console.log(query);
      if (error) {
        callback({ status: "fail", code: ERROR, error: error.message });
        console.log(callback);
      } else {
        callback({ status: "success", code: SUCCESS });
        console.log(callback);
      }
    }
  );
};

exports.delete = function (unique_id_name, unique_id, table, callback) {
  
  
  
  let query = "DELETE FROM " + table + " WHERE " + unique_id_name + " =?";
  connection.query(query, [unique_id], function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({ status: "success", code: SUCCESS });
      console.log(callback);
    }
  });
};
exports.delete_direct = function (query, callback) {
  
  
  

  connection.query(query, function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({ status: "success", code: SUCCESS });
      console.log(callback);
    }
  });
};

exports.select_first = function (query, callback) {
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      console.log(error);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      if (results.length == 0) {
        callback({ status: "fail", code: ERROR_EMPTY, error: "No Data Found" });
      } else {
        callback({ status: "success", code: SUCCESS, result: results[0] });
      }
    }
  });
};

exports.selectAll = function (query, callback) {
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      if (results.length == 0) {
        callback({ status: "fail", code: ERROR_EMPTY, error: "No Data Found" });
      } else {
        callback({ status: "success", code: SUCCESS, result: results });
      }
    }
  });
};

exports.updateMultiple = function (
  table,
  values,
  unique_column_name,
  callback
) {
  console.log(values);
  let queries = "";
  values.forEach(function (item) {
    Object.keys(item);

    queries += "UPDATE " + table + " set ";
    let keys = Object.keys(item);
    keys.forEach(function (key, i) {
      console.log(key);

      if (key == unique_column_name) {
        if (i == keys.length - 1) {
          queries +=
            " where " +
            unique_column_name +
            " = " +
            item[unique_column_name] +
            ";";
        }
      } else {
        queries += key + " = '" + item[key] + "'";
        if (i == keys.length - 1) {
          queries +=
            " where " +
            unique_column_name +
            " = " +
            item[unique_column_name] +
            ";";
        } else {
          queries += " and ";
        }
      }
    });

    
  });
  console.log(queries);
  connection.query(queries, (error, results, fields) => {
    
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      callback({ status: "success", code: SUCCESS });
    }
  });
  
  
  
  
  
  
  
  
  
  
  
};

exports.insert_multiple_rows = function (
  table_fields,
  object_array,
  table,
  callback
) {
  
  
  
  let query = "INSERT INTO " + table + table_fields + " VALUES ?";
  connection.query(query, object_array, function (error, results, fields) {
    console.log(query);
    if (error) {
      callback({ status: "fail", code: ERROR, error: error.message });
      console.log(callback);
    } else {
      callback({
        status: "success",
        code: SUCCESS,
        id: results.insertId
      });
      console.log(callback);
    }
  });
};

exports.execute_query = function (query, callback) {
  console.log(query);
  connection.query(query, (error, results, fields) => {
    console.log(query);
    if (error) {
      console.log(error.message);
      callback({ status: "fail", code: ERROR, error: error.message });
    } else {
      callback({ status: "success", code: SUCCESS });
    }
  });
};
```

## File: controllers\copyFile.js

```javascript
const fs = require("fs");
let common = require("./common");
let config = require("../config/config").config();
let admin_common = require("./admin_common");

exports.download_files = function (req, res) {
  const fs = require("fs");

  
  let query = "select * from video where subject_id = " + req.query.subject_id;

  admin_common.selectAll(query, function (callback) {
    if (callback.code == 200) {
      
      var urls = callback.result.map((item) => [item.video_path]);
      console.log("urls----------------------------->");
      console.log(urls);
      download_files(callback.result, urls, function (call1) {
        console.log(call1);

        var table_fields =
          "(video_id,subject_id,video_path,video_name," +
          "video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) ";

        let items = call1.result;

        var object_array = [
          items.map((item) => [
            item.video_id,
            item.subject_id,
            item.video_path,
            item.video_name,
            item.video_extension,
            item.video_desc,
            item.is_delete,
            item.is_active,
            item.created_by,
            item.created_date,
            item.modified_by,
            item.modified_date,
            item.ip_address
          ])
        ];

        var table = "video";

        common.insert_multiple_rows(
          table_fields,
          object_array,
          table,
          function (callback1) {
            res.json(callback1);
          }
        );

        
      });
    } else {
      res.json(callback);
    }
  });
};

function download_files(list, urls, callback) {
  const https = require("https");
  const downloadFolderPath = "public/";
  const downloadFile = (url) => {
    return new Promise((resolve, reject) => {
      
      console.log("url------------------>");
      console.log(url);

      const splitUrl = url.split("/");
      const filename = splitUrl[splitUrl.length - 1];
      const foldername = splitUrl[splitUrl.length - 2];
      const outputPath = `${downloadFolderPath}${foldername}/${filename}`;

      console.log(outputPath);

      const file = fs.createWriteStream(outputPath);

      if (!fs.existsSync(`${downloadFolderPath}${foldername}`)) {
        fs.mkdirSync(`${downloadFolderPath}${foldername}`, {
          recursive: true
        });
      }

      https.get(url, (res) => {
        if (res.statusCode === 200) {
          console.log("get success");
          res.pipe(file).on("close", resolve);
        } else {
          reject(res.statusCode);
          console.log("get error" + res.statusCode);
        }
      });
    });
  };

  let downloadedFiles = 0;

  list.forEach(async (item) => {
    let url = item.video_path;

    const splitUrl = url.split("/");
    const filename = splitUrl[splitUrl.length - 1];
    const foldername = splitUrl[splitUrl.length - 2];

    item.video_path = foldername + "/" + filename;

    await downloadFile(url);

    downloadedFiles++;

    console.log(`${downloadedFiles}/${urls.length} downloaded`);
    if (downloadedFiles === urls.length) {
      console.log("downloadedFiles complete");
      callback({ code: 200, status: "success", result: list });
    }
  });

  
  
  
  
  
  
  
  
  
}

exports.copy_file1 = function (req, res) {
  var client = require("scp2");

  client.scp(
    {
      host: config.remote_server.host,
      username: config.remote_server.username,
      password: config.remote_server.password,
      path: "/home/test/"
    },
    "./uploads/",
    function (err) {
      if (err) {
        console.log(err);
        res.send(err);
        
      } else {
        res.send("Done");
        
      }
    }
  );
};

exports.copy_file = function (req, res) {
  const scp = require("node-scp");

  test(scp, function (callback) {
    res.send(callback);
  });
};

async function test(scp, callback) {
  try {
    const client = await scp({
      host: config.remote_server.host,
      port: 22,
      username: config.remote_server.username,
      password: config.remote_server.password
      
      
    });
    console.log("start uploading");
    await client.downloadDir("/home/test/uploads", "./uploads");

    client.close(); 
    callback("done");
  } catch (e) {
    console.log(e);
    callback(e);
  }
}
```

## File: controllers\DbController.js

```javascript
const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");
let config = require("../config/config").config();

const { exec } = require("child_process");
const { request } = require("http");
const async = require("async");

exports.update_video_data = function (req, res) {};

exports.update_course = function (req, res) {
  let request = req.query;

  check_connection(function (connected) {
    if (connected == 1) {
      admin_common.select_first(
        "select * from box_update_status where box_id = " + request.box_id,
        function (callback1) {
          if (callback1.code == SUCCESS) {
            updateAllData(
              1,
              callback1.result.last_updated_log_id,
              request.course_id,
              request.box_id,
              function (call2) {
                res.json(call2);
              }
            );
          } else if (callback1.code == ERROR_EMPTY) {
            updateAllData(
              0,
              0,
              request.course_id,
              request.box_id,
              function (call3) {
                res.json(call3);
              }
            );
          } else {
            res.json(callback1);
          }
        }
      );
    } else {
      showInternetError(res);
    }
  });
};

async function updateAllData(
  isFirstTime,
  last_updated_log_id,
  course_id,
  box_id,
  callback
) {
  admin_common.selectAll(
    "select * from trigger_log where course_id = " +
      course_id +
      " and log_id > " +
      last_updated_log_id,
    async function (call1) {
      if (call1.code == SUCCESS) {
        let response = {};

        async.eachSeries(call1.result, (item, next) => {
          console.log(
            "log_id----========================----->    " + item.log_id
          );
          doAction(item, function (call2) {
            console.log("Do Action Result ------------->  " + call2);
            response = call2;
            console.log(response);
            if (call2.code == SUCCESS) {
              storeUpdatedId(box_id, item.log_id);
            } else {
              console.log(call2.status);
              i = call1.result.length;
              
            }
            if (item == call1.result[call1.result.length - 1]) {
              console.log("--------------last item-----------------------");
              callback(response);
              return;
            } else {
              next();
            }
          });
        });

        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        
      } else {
        callback(call1);
      }
    }
  );
}

function storeUpdatedId(box_id, log_id) {
  let obj = {
    box_id: box_id,
    last_updated_log_id: log_id
  };

  admin_common.select_first(
    "select status_id from box_update_status where box_id = " + box_id,
    function (call1) {
      console.log(call1.code);
      if (call1.code == SUCCESS) {
        admin_common.update(
          obj,
          "status_id",
          call1.result.status_id,
          "box_update_status",
          function (call) {
            console.log(call.code);
          }
        );
      } else {
        admin_common.insert(obj, "box_update_status", function (call) {
          console.log(call.code);
        });
      }
    }
  );
}

async function doAction(item, callback) {
  console.log("========go into DoAction ======================");
  if (item.action == "insert") {
    console.log("insert");
    insert_data(item, function (call1) {
      callback(call1);
    });
  } else if (item.action == "update") {
    console.log("update");
    update_data(item, function (call2) {
      console.log("update data ------------->" + call2.code);

      callback(call2);
    });
  } else if (item.action == "delete") {
    console.log("delete");
    delete_data(item, function (call3) {
      callback(call3);
    });
  } else {
    callback();
  }
}

function delete_data(item, callback) {
  const fs = require("fs");
  if (item.table_name == "video") {
    common.select_first(
      "select video_path from video where video_id = " + item.primary_key_id,
      function (call2) {
        if (call2.code == SUCCESS) {
          fs.unlink(call2.result.video_path, function (err, result) {
            if (err) {
              console.log("error in deleting file ..........");
            } else {
              common.delete(
                item.primary_key_name,
                item.primary_key_id,
                item.table_name,
                function (call1) {
                  callback(call1);
                }
              );
            }
            next(err, list);
          });
        } else {
          callback(errorJsonObject);
        }
      }
    );
  } else if (item.table_name == "note") {
    common.select_first(
      "select note_path from note where note_id = " + item.primary_key_id,
      function (call2) {
        fs.unlink(call2.result.video_path, function (err, result) {
          next(err, list);
          if (err) {
            console.log("error in deleting file ..........");
          } else {
            common.delete(
              item.primary_key_name,
              item.primary_key_id,
              item.table_name,
              function (call1) {
                callback(call1);
              }
            );
          }
        });
      }
    );
  }
}

const downloadFile = (url, callback) => {
  return new Promise((resolve, reject) => {
    const https = require("https");
    let downloadFolderPath = "./public/video/";
    console.log("url------------------>");
    console.log(url);

    const splitUrl = url.split("/");
    const filename = splitUrl[splitUrl.length - 1];
    const foldername = splitUrl[splitUrl.length - 2];
    const outputPath = `${downloadFolderPath}${foldername}/${filename}`;

    console.log(outputPath);

    const file = fs.createWriteStream(outputPath);

    if (!fs.existsSync(`${downloadFolderPath}${foldername}`)) {
      fs.mkdirSync(`${downloadFolderPath}${foldername}`, {
        recursive: true
      });
    }

    https.get(url, (res) => {
      if (res.statusCode === 200) {
        console.log("get success");
        res.pipe(file).on("close", resolve);
        callback(res.statusCode);
      } else {
        reject(res.statusCode);
        callback(res.statusCode);
        console.log("get error" + res.statusCode);
      }
    });
  });
};

function insert_data(item, callback) {
  let query =
    "select * from " +
    item.table_name +
    " where " +
    item.primary_key_name +
    " = " +
    item.primary_key_id;

  admin_common.select_first(query, function (call1) {
    if (call1.code == SUCCESS) {
      if (item.table_name == "video" || item.table_name == "note") {
        downloadFile(call1.result.video_path, function (callback1) {
          console.log(call1.result);
          if (callback1 == 200) {
            common.insert(call1.result, item.table_name, function (call2) {
              console.log(call2.status);
              callback(call2);
            });
          } else {
            callback({
              code: 400,
              status: "error",
              error: "Error in downloading the File"
            });
          }
        });
      } else {
        common.insert(call1.result, item.table_name, function (call2) {
          console.log(call2.status);
          callback(call2);
        });
      }
    } else {
      callback(errorJsonObject);
    }
  });
}

function update_data(item, callback) {
  let query =
    "select * from " +
    item.table_name +
    " where " +
    item.primary_key_name +
    " = " +
    item.primary_key_id;

  admin_common.select_first(query, function (call1) {
    if (call1.code == SUCCESS) {
      if (item.table_name == "video" || item.table_name == "note") {
        fs.unlink(call1.result.video_path, function (err, result) {
          if (err) {
            console.log("error in deleting file ..........");
          } else {
            downloadFile(call1.result.video_path, function (callback1) {
              if (callback1 == 200) {
                common.update(
                  call1.result,
                  item.primary_key_name,
                  item.primary_key_id,
                  item.table_name,
                  function (call2) {
                    console.log(call2.status);
                    callback(call2);
                  }
                );
              } else {
                callback({
                  code: 400,
                  status: "error",
                  error: "Error in downloading the File"
                });
              }
            });
          }
          
        });
      } else {
        common.update(
          call1.result,
          item.primary_key_name,
          item.primary_key_id,
          item.table_name,
          function (call2) {
            console.log(call2.status);
            callback(call2);
          }
        );
      }
    } else {
      callback(errorJsonObject);
    }
  });
}

function errorJsonObject() {
  return {
    code: 400,
    status: "error",
    error: "Can not fetch data"
  };
}

function showInternetError(res) {
  res.json({
    code: 400,
    status: "error",
    error: "Internet connection is not available."
  });
}

exports.ping = function (req, res) {
  let request = req.query;
  check_connection(function (connected) {
    if (connected == 1) {
      admin_common.select_first(
        "select * from box where box_id = " + request.box_id,
        function (call1) {
          if (call1.code == SUCCESS) {
            let obj = {
              box_id: request.box_id,
              created_by: request.box_id,
              created_date: getCurrentDateTime()
            };
            admin_common.insert(obj, "box_health", function (callback) {
              res.json(callback);
            });
          } else {
            res.json({
              code: 400,
              status: "error",
              error:
                "There are no box available in the admin with id = " +
                request.box_id
            });
          }
        }
      );
    } else {
      res.json({
        code: 400,
        status: "error",
        error: "Internet connection is not available."
      });
    }
  });
};

exports.get_box_updates = function (req, res) {
  admin_common.selectAll("select * from v_box_health", function (callback) {
    res.json(callback);
  });
};

function check_connection(callback) {
  let connected = 0;
  require("dns").resolve("www.google.com", function (err) {
    if (err) {
      connected = 0;
      console.log("No connection");
      callback(connected);
    } else {
      connected = 1;
      console.log("Connected");
      callback(connected);
    }
  });
}

exports.update_subject_data = function (req, res) {
  let created_date = req.query.created_date;

  check_connection(function (connected) {
    if (connected == 1) {
      let query =
        "select * from subject where created_date <'" +
        created_date +
        "' and modified_date >'" +
        created_date +
        "'";

      admin_common.selectAll(query, function (callback) {
        if (callback.code == SUCCESS) {
          
          common.updateMultiple(
            "subject",
            callback.result,
            "subject_id",
            function (callback) {
              
              insert_subject_data(created_date, function (callback1) {
                res.json(callback1);
              });
            }
          );
        } else {
          
          insert_subject_data(created_date, function (callback1) {
            res.json(callback1);
          });
        }
      });
    } else {
      res.json({ code: 400, status: "Internet connection is not available." });
    }
  });
};

function insert_subject_data(created_date, callback) {
  let query2 =
    "select * from subject where created_date >'" + created_date + "'";
  admin_common.selectAll(query2, function (callback2) {
    if (callback2.code == SUCCESS) {
      var table_fields =
        "(subject_id,course_id,subject_name,subject_desc," +
        "note_name,note_url,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) ";

      let items = callback2.result;

      var object_array = [
        items.map((item) => [
          item.subject_id,
          item.course_id,
          item.subject_name,
          item.subject_desc,
          item.note_name,
          item.note_url,
          item.is_delete,
          item.is_active,
          item.created_by,
          item.created_date,
          item.modified_by,
          item.modified_date,
          item.ip_address
        ])
      ];

      var table = "subject";

      common.insert_multiple_rows(
        table_fields,
        object_array,
        table,
        function (callback1) {
          callback(callback1);
        }
      );
    } else {
      callback({ code: 600, status: "Already up to date" });
    }
  });
}

exports.updateDatabase = function (req, res) {
  delete_db(function (call) {
    if (call.code == SUCCESS) {
      console.log(
        `Starting exporting data from the ${config.export_db.database} database`
      );

      
      

      
      exec(
        `mysqldump --defaults-extra-file=.my.cnf -u${config.export_db.username} -h${config.export_db.host} --compact ${config.export_db.database} > ${config.dumpFile}`,
        (err, stdout, stderr) => {
          if (err) {
            console.error(`exec error: ${err}`);
            return;
          }
          console.log(
            `Now, importing data to the ${config.import_db.database} database`
          );
          import_db(config.dumpFile, function (callback) {
            res.json(callback);
          });
        }
      );
    } else {
      console.log("error");
      res.json({
        code: ERROR,
        error: "SOME ERROR OCCURED"
      });
    }
  });
};

async function deleteAll(result, callback) {
  for await (query of result) {
    common.execute_query(query.drop_query, function (call) {
      
    });
  }

  callback({
    code: SUCCESS
  });
}

function deleteAllTables(call) {
  let q =
    "SELECT CONCAT('DROP TABLE IF EXISTS `', table_schema, '`.`', table_name, '`;') as drop_query" +
    "  FROM   information_schema.tables" +
    "  WHERE  table_schema = 'lms'";

  common.selectAll(q, function (callback) {
    console.log(callback);

    if (callback.code === SUCCESS) {
      deleteAll(callback.result, function (callback1) {
        console.log(callback1);
        call(callback1);
      });
    } else if (callback.code == ERROR_EMPTY) {
      call({
        code: SUCCESS
      });
    } else {
      call({
        code: ERROR
      });
    }
  });
}

function deleteAllViews(call) {
  let q =
    "SELECT CONCAT('DROP VIEW IF EXISTS `', table_schema, '`.`', table_name, '`;') as drop_query FROM information_schema.views WHERE table_schema = 'lms'";
  common.selectAll(q, function (call2) {
    console.log("***********************************");
    console.log(call2);
    console.log("**************************************");
    if (call2.code === SUCCESS) {
      deleteAll(call2.result, function (callback2) {
        console.log(callback2);
        call(callback2);
      });
    } else if (call2.code == ERROR_EMPTY) {
      call({
        code: SUCCESS
      });
    } else {
      call({
        code: ERROR
      });
    }
  });
}

async function delete_db(call) {
  deleteAllTables(function (call1) {
    if (call1.code == SUCCESS) {
      deleteAllViews(function (call2) {
        call(call2);
      });
    } else {
      call(call1);
    }
  });
}

async function replace(string, callback) {
  const replacer = new RegExp("utf8mb4_0900_ai_ci", "g");
  const replacer1 = new RegExp("ALGORITHM=UNDEFINED", "g");
  const replacer2 = new RegExp(
    "DEFINER=`nidhi`@`localhost` SQL SECURITY DEFINER",
    "g"
  );
  const searchRegExp = "utf8mb4_0900_ai_ci";
  const replaceWith = "utf8mb4_general_ci";

  let result = await string.replace(replacer, replaceWith);
  console.log(result);
  let result2 = await result.replace(replacer1, "");
  let result3 = await result2.replace(replacer2, "");
  
  callback(result3);
}

async function import_db(filepath, callback1) {
  let dataArr = fs.readFileSync(filepath, { encoding: "UTF-8" });

  replace(dataArr, function (callback) {
    dataArr = callback.split(";\n");

    for (let query of dataArr) {
      common.execute_query(query, function (callback) {
        console.log(callback);
      });
    }
    callback1({ code: SUCCESS });
  });

  

  
}
```

## File: controllers\db_update.js

```javascript
const fs = require("fs");
let common = require("./common");
let admin_common = require("./admin_common");
let config = require("../config/config").config();

exports.update_content_server_to_box = function (req, res) {
  check_connection(function (connected) {
    if (connected == 1) {
      common.selectAll("select * from courses");
    } else {
      res.json({
        code: 400,
        status: "error",
        error: "Internet connection is not available."
      });
    }
  });
};

function check_connection(callback) {
  let connected = 0;
  require("dns").resolve("www.google.com", function (err) {
    if (err) {
      connected = 0;
      console.log("No connection");
      callback(connected);
    } else {
      connected = 1;
      console.log("Connected");
      callback(connected);
    }
  });
}
```

## File: controllers\download_file.js

```javascript
const axios = require("axios");
const fs = require("fs");
const path = require("path");

exports.download = async function (req, res1) {
  let url = req.query.url;

  let type = req.query.type;
  let downloadFolderPath = "./public/video/";
  if (type == 1) {
    downloadFolderPath = "./public/video/";
  } else {
    downloadFolderPath = "./public/notes/";
  }

  new Promise((resolve, reject) => {
    const https = require("https");
    let downloadFolderPath = "./public/video/";
    console.log("url------------------>");
    console.log(url);

    const splitUrl = url.split("/");
    const filename = splitUrl[splitUrl.length - 1];
    const foldername = splitUrl[splitUrl.length - 2];
    const outputPath = `${downloadFolderPath}${foldername}/${filename}`;

    console.log(outputPath);

    const file = fs.createWriteStream(outputPath);

    if (!fs.existsSync(`${downloadFolderPath}${foldername}`)) {
      fs.mkdirSync(`${downloadFolderPath}${foldername}`, {
        recursive: true
      });
    }

    https.get(url, (res) => {
      if (res.statusCode === 200) {
        console.log("get success");
        res.pipe(file).on("close", resolve);
        res1.json({ status: res.statusCode.toString(), code: "200" });
      } else {
        reject(res.statusCode);
        res1.json({ status: res.statusCode.toString(), code: "400" });
        console.log("get error" + res.statusCode);
      }
    });
  });
};
```

## File: controllers\item.js

```javascript
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
```

## File: controllers\log.js

```javascript
let common = require('./common');

let moment = require("moment-timezone");

function getCurrentDateTime() {
    return moment.tz(new Date(), "Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}


exports.send_log = function sendLog(type, response, error) {

    let log = {
        "type": type,
        "success": response,
        "error": error,
        "created_date": getCurrentDateTime()
    }
    common.insert(log, "log", function (callback) {
        console.log(callback);
    });
}
```

## File: controllers\quiz.js

```javascript
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
  common.selectAll(
    "select * from subjects where course_id = " +
      course_id +
      " and student_id = " +
      student_id,
    function (callback) {
      res.json(callback);
    }
  );
};









































































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
          
          
        } else {
          callback1({ progress: 0 });
        }
      } else {
        callback1({ progress: 0 });
      }
    }
  );
  
}

exports.get_video = function (req, res) {
  let subject_id = req.query.subject_id;
  let student_id = req.query.student_id;

  common.selectAll(
    "select * from videos where subject_id = " +
      subject_id +
      " and student_id = " +
      student_id,
    function (call1) {
      console.log(call1);
      res.json(call1);
    }
  );
};










































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

  common.selectAll(
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
```

## File: controllers\student.js

```javascript
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
      
    }
  );

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
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
```

## File: controllers\syncData.js

```javascript
const fs = require("fs");
let common = require("./common");
let config = require("../config/config").config();
let admin_common = require("./admin_common");

exports.check_connection = function (req, res) {
  let data = req.query;

  let obj = {
    device_id: data.device_id,
    device_mac_address: data.device_mac_address
  };
  admin_common.insert(obj, "gateway_server", function (callback1) {

    

  });
};
```

## File: controllers\temperature.js

```javascript
const { exec } = require("child_process");
let common = require("./common");













exports.disable_access_point = function (req, res) {
  exec(
    `sudo systemctl disable dnsmasq && sudo systemctl disable hostapd`,
    (err, stdout, stderr) => {
      if (err) {
        console.error(`exec error: ${err}`);
        res.json({ code: "400", error: err });
        return;
      }
      console.log(`stdout: ${stdout}`);
      console.log(`stderr: ${stderr}`);
      
    }
  );
};

function check_temperature() {
  exec(`sudo vcgencmd measure_temp`, (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log(stdout.split("=")[1].split("'")[0]);
    console.log(`stdout: ${stdout}`);
    console.log(`stderr: ${stderr}`);
    
  });
}

exports.reboot = function (req, res) {
  exec(`sudo reboot`, (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    console.log(`stderr: ${stderr}`);
    
  });
};

exports.disable_access_point1 = function (req, res) {
  const { spawn } = require("child_process");

  
  const pythonScriptPath = "../Public/Networks/connect.py";

  
  const pythonProcess = spawn("python", [pythonScriptPath]);

  
  pythonProcess.stdout.on("data", (data) => {
    console.log(`Python stdout: ${data}`);
    res.json({
      code: "200",
      status: "success",
      result: `Python stdout: ${data}`
    });
  });

  pythonProcess.stderr.on("data", (data) => {
    res.json({
      code: "400",
      status: "error",
      error: `Python stderr: ${data}`
    });
    console.error(`Python stderr: ${data}`);
  });

  
  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);
  });
};

exports.enable_access_point = function (req, res) {
  const { spawn } = require("child_process");

  
  const pythonScriptPath = "../Public/Networks/access.py";

  
  const pythonProcess = spawn("python", [pythonScriptPath]);

  
  pythonProcess.stdout.on("data", (data) => {
    console.log(`Python stdout: ${data}`);
    
    
    
    
    
  });

  pythonProcess.stderr.on("data", (data) => {
    
    
    
    
    
    console.error(`Python stderr: ${data}`);
  });

  
  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);
  });
};
```

## File: controllers\upload.js

```javascript
const util = require("util");
const multer = require("multer");
const maxSize_for_note = 2 * 1024 * 1024;
const maxSize_for_video = 500 * 1024 * 1024;
let config = require("../config/config").config();
global.notes_path = "public/notes";
global.videoes_path = "public/videoes";

let storage_for_file = multer.diskStorage({
  destination: (req, file, cb) => {
    
    cb(null, notes_path);
  },
  filename: (req, file, cb) => {
    console.log(file.originalname);
    cb(null, file.originalname);
  },
});

exports.uploadFile = multer({
  storage: storage_for_file,
  limits: { fileSize: maxSize_for_note },
});

let storage_for_video = multer.diskStorage({
  destination: (req, file, cb) => {
    
    cb(null, videoes_path);
  },
  filename: (req, file, cb) => {
    console.log(file.originalname);
    cb(null, file.originalname.split(" ").join("_").toLowerCase());
  },
});

exports.uploadVideo = multer({
  storage: storage_for_video,
  limits: { fileSize: maxSize_for_video },
});
```

## File: controllers\video.js

```javascript
const fs = require('fs');
let common = require('./common');
let admin_common = require('./admin_common');

const multer = require('multer');

const upload_video = require("./video_upload.js");


var storage = multer.diskStorage({
    destination: function (req, file, cb) {

        
        cb(null, "uploads")
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + "-" + Date.now() + ".jpg")
    }
});



const maxSize = 1 * 1000 * 1000;

var upload = multer({
    storage: storage,
    limits: {fileSize: maxSize},
    fileFilter: function (req, file, cb) {

        
        var filetypes = /jpeg|jpg|png/;
        var mimetype = filetypes.test(file.mimetype);

        var extname = filetypes.test(path.extname(
            file.originalname).toLowerCase());

        if (mimetype && extname) {
            return cb(null, true);
        }

        cb("Error: File upload only supports the "
            + "following filetypes - " + filetypes);
    }


}).single("mypic");


exports.upload_video = function (req, res) {
    upload(req, res, function (err) {
        if (err) {
            
            
            
            res.send(err)
        } else {
            
            res.send("Success, Image uploaded!")
        }
    });
}
```

## File: controllers\video_upload.js

```javascript
var Busboy = require("busboy");
var path = require("path");
var fs = require("fs");
var sha1 = require("sha1");


function getExtension(filename) {
    return filename.split(".").pop();
}


function isFileValid(filename, mimetype) {
    var allowedExts = ["mp4", "webm", "ogg"];
    var allowedMimeTypes = ["video/mp4", "video/webm", "video/ogg"];

    
    var extension = getExtension(filename);

    return allowedExts.indexOf(extension.toLowerCase()) != -1  &&
        allowedMimeTypes.indexOf(mimetype) != -1;
}

function upload (req, callback) {
    
    var fileRoute = "/uploads/";

    
    var saveToPath = null;

    
    var hadStreamError = null;

    
    var link = null;

    
    function handleStreamError(error) {
        
        if (hadStreamError) {
            return;
        }

        hadStreamError = error;

        
        if (saveToPath) {
            return fs.unlink(saveToPath, function (err) {
                return callback(error);
            });
        }

        return callback(error);
    }

    
    try {
        var busboy = new Busboy({ headers: req.headers });
    } catch(e) {
        return callback(e);
    }

    
    busboy.on("file", function(fieldname, file, filename, encoding, mimetype) {
        
        if ("file" != fieldname) {
            
            file.resume();
            return callback("Fieldname is not correct. It must be " + file + ".");
        }

        
        var randomName = sha1(new Date().getTime()) + "." + getExtension(filename);
        link = fileRoute + randomName;

        
        var appDir = path.dirname(require.main.filename);
        saveToPath = path.join(appDir, link);

        
        file.on("error", handleStreamError);

        
        var diskWriterStream = fs.createWriteStream(saveToPath);
        diskWriterStream.on("error", handleStreamError);

        
        diskWriterStream.on("finish", function() {
            
            var status = isFileValid(saveToPath, mimetype);

            if (!status) {
                return handleStreamError("File does not meet the validation.");
            }

            return callback(null, {link: link});
        });

        
        file.pipe(diskWriterStream);
    });

    
    busboy.on("error", handleStreamError);
    req.on("error", handleStreamError);

    
    return req.pipe(busboy);
}

module.exports = upload;
```

## File: routes\index.js

```javascript
var express = require("express");

var router = express.Router();

const item = require("../controllers/item");
const quiz = require("../controllers/quiz");
const student = require("../controllers/student");
const copyFile = require("../controllers/copyFile");
const video = require("../controllers/video");
const db = require("../controllers/DbController");
const temp = require("../controllers/temperature");
const uploadFile = require("../controllers/upload");
const add_data_to_box = require("../controllers/add_data_to_box1");
const commands = require("../controllers/commands");


router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});

router.get("/_health", (req, res) => {
  res.status(200).send("ok");
});









router.get("/api/update_database", db.updateDatabase);
router.get("/api/download_files", copyFile.download_files);

router.get("/update_subject_data", db.update_subject_data);
router.get("/update_video_data", db.update_video_data);
router.get("/api/ping", db.ping);
router.get("/api/get_box_updates", db.get_box_updates);
router.get("/api/update_course", db.update_course);

router.get("/api/update_database_data", item.update_database_data);
router.get("/api/copy_file", copyFile.copy_file);
router.post("/api/upload_video", video.upload_video);

router.get("/api/reboot", temp.reboot);



router.get("/api/get_quiz", quiz.get_quiz);
router.get("/api/get_course", quiz.get_course);
router.get("/api/get_subject", quiz.get_subject);
router.get("/api/get_video", quiz.get_video);
router.get("/api/get_note", quiz.get_note);
router.post("/api/add_result", quiz.add_result);
router.post("/api/add_progress", quiz.add_progress);
router.get("/api/get_result", quiz.get_result);
router.get("/api/get_result_detail", quiz.get_result_detail);



router.get("/api/login", student.login);
router.get(
  "/api/check_device_for_reset_pwd",
  student.check_device_for_reset_pwd
);
router.get(
  "/api/f_check_device_for_reset_pwd",
  student.f_check_device_for_reset_pwd
);
router.get("/api/change_pwd", student.change_pwd);
router.get("/api/f_change_pwd", student.f_change_pwd);

router.get("/api/signout", student.signout);
router.post("/api/f_login", student.f_login);
router.get("/api/get_profile", student.get_profile);
router.get("/api/check_student_status", student.check_student_status);

router.post("/api/add_student", student.add_student);
router.post("/api/add_student_attendance", student.add_student_attendance);
router.get("/api/get_attendance_report", student.get_attendance_report);
router.get(
  "/api/get_attendance_report_by_student",
  student.get_attendance_report_by_student
);
router.post("/api/call_reset_device", student.call_reset_device);
router.get("/api/get_student", student.get_student);



router.get("/api/get_all_quiz", quiz.get_all_quiz);
router.get("/api/get_course", quiz.get_course);
router.post("/api/add_course", quiz.add_course);
router.post("/api/edit_course", quiz.edit_course);
router.post("/api/delete_course", quiz.delete_course);
router.get("/api/get_all_subject", quiz.get_all_subject);
router.post(
  "/api/add_subject",
  uploadFile.uploadFile.single("file"),
  quiz.add_subject
);

router.post("/api/edit_subject", quiz.edit_subject);
router.post(
  "/api/edit_subject_with_file",
  uploadFile.uploadFile.single("file"),
  quiz.edit_subject
);
router.post("/api/delete_subject", quiz.delete_subject);
router.get("/api/get_note", quiz.get_note);
router.post(
  "/api/add_note",
  uploadFile.uploadFile.single("file"),
  quiz.add_note
);
router.post(
  "/api/add_video",
  uploadFile.uploadVideo.single("file"),
  quiz.add_video
);

router.post("/api/edit_note", quiz.edit_note);
router.post(
  "/api/edit_note_with_file",
  uploadFile.uploadFile.single("file"),
  quiz.edit_note
);

router.post("/api/delete_note", quiz.delete_note);

router.get("/api/get_all_video", quiz.get_all_video);

router.post("/api/edit_video", quiz.edit_video);

router.post(
  "/api/edit_video_with_file",
  uploadFile.uploadVideo.single("file"),
  quiz.edit_video
);
router.post("/api/delete_video", quiz.delete_video);

router.post("/api/delete_quiz", quiz.delete_quiz);
router.post("/api/edit_quiz", quiz.edit_quiz);
router.post("/api/add_quiz", quiz.add_quiz);
router.post("/api/add_multiple_quiz", quiz.add_multiple_quiz);
router.post("/api/admin_login", quiz.admin_login);

router.post("/api/add_box_details", quiz.add_box_details);

router.post("/api/add_wifi_cred", commands.add_wifi_cred);
router.post("/api/shut_down", commands.shut_down);
router.post("/api/reboot", commands.reboot);



module.exports = router;
```

## File: routes\sync_data.js

```javascript
var express = require("express");

var router = express.Router();

const syncData = require("../controllers/syncData");
const download = require("../controllers/download_file");
const add_data_to_box = require("../controllers/add_data_to_box");
const temp = require("../controllers/temperature");


router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});
router.get("/_health", (req, res) => {
  res.status("200").send("ok");
});

router.get("/api/check_connection", syncData.check_connection);
router.get("/api/download", download.download);


router.get("/api/disable_access_point", temp.disable_access_point1);
router.get(
  "/api/download_course_with_course_id",
  add_data_to_box.download_course_with_course_id
);
router.get(
  "/api/add_course_to_box_from_server",
  add_data_to_box.add_course_to_box_from_server
);
router.get(
  "/api/download_course_with_course_id",
  add_data_to_box.download_course_with_course_id
);
router.get("/api/download_old_course", add_data_to_box.download_old_course);

module.exports = router;
```

## File: index.js

```javascript
#!/usr/bin/env node


let config = require("./config/config").config();
var createError = require("http-errors");
var express = require("express");
var path = require("path");                          
var cookieParser = require("cookie-parser");
var logger = require("morgan");
const upload = require("express-fileupload");



var firebase = require("firebase/app");
const cors = require("cors");


require("firebase/auth");
require("firebase/firestore");

var indexRouter = require("./routes/index");
var syncDataRouter = require("./routes/sync_data");

var app = express();
app.use(cors());

process.env.TZ = "Asia/Kolkata";


app.engine("pug", require("pug").__express);


app.set("views", path.join(process.cwd(), config.base_path + "views"));

app.set("view engine", "pug");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(process.cwd(), config.base_path + "public")));

app.use("/", indexRouter);
app.use("/", syncDataRouter);
app.use(
  upload({
    limits: { filesize: 50 * 1024 * 1024 }
  })
);
app.get("/upload", function (req, res) {
  res.sendFile(__dirname + "/index.html");
});
app.post("/upload", (req, res) => {
  if (req.files) {
    console.log(req.files);
    var file = req.files.file;
    var filename = file.name;
    console.log(filename);

    file.mv("G:/uploads/" + filename, function (err) {
      if (err) {
        res.send(err);
      } else {
        res.send({ message: "file uploaded" });
      }
    });
  }
});

app.all("
const hostname = "0.0.0.0";
var port = normalizePort(process.env.PORT || "3002");
app.set("port", port);



var server = http.createServer(app);

console.log("add data from server to the box starting...........");

const b = require("./controllers/add_data_to_box");
b.add_course_to_box_from_server(function (callback) {
  console.log(callback);
});












server.listen(port, hostname, () =>
  console.log(`Hello world app listening on port ${port}!`)
);

server.on("error", onError);
server.on("listening", onListening);



function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    
    return val;
  }

  if (port >= 0) {
    
    return port;
  }

  return false;
}



function onError(error) {
  if (error.syscall !== "listen") {
    throw error;
  }

  var bind = typeof port === "string" ? "Pipe " + port : "Port " + port;

  
  switch (error.code) {
    case "EACCES":
      console.error(bind + " requires elevated privileges");
      process.exit(1);
      break;
    case "EADDRINUSE":
      console.error(bind + " is already in use");
      process.exit(1);
      break;
    default:
      throw error;
  }
}



function onListening() {
  var addr = server.address();
  var bind = typeof addr === "string" ? "pipe " + addr : "port " + addr.port;
  debug("Listening on " + bind);
}

module.exports = {
  app
};
```

## File: course_data.sql

```sql
INSERT INTO course (course_id,course_name,course_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('5','LAW','Civil Procedure Code','0','1',NULL,'2023-10-12 14:06:47','1','2023-10-19 20:54:54',NULL);

INSERT INTO subject (subject_id,course_id,subject_name,subject_desc,note_name,note_url,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('6','5','Civil Procedure Code','Civil Procedure Code','1.pdf','notes/1697729828769.pdf','0','1',NULL,'2023-10-12 14:07:26',NULL,'2023-10-19 21:07:08',NULL);
INSERT INTO subject (subject_id,course_id,subject_name,subject_desc,note_name,note_url,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('7','5','Robotics','Robotics Video Course','Kitting.pdf','notes/1697099876616.pdf','0','1',NULL,'2023-10-12 14:07:56',NULL,'2023-10-12 08:37:56',NULL);INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('10','6','videoes/1697729892390.mp4','CPC Video 1','','Civil Procedure Code','0','1',NULL,'2023-10-19 21:08:13',NULL,'2023-10-19 21:59:52',NULL);

INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('11','6','videoes/1697733094107.mp4','CPC Video 2','mp4','Civil Procedure Code','0','1',NULL,'2023-10-19 22:01:35',NULL,'2023-10-19 16:31:35',NULL);

INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('12','6','videoes/1697733450519.mp4','CPC Video 3','mp4','Civil Procedure Code','0','1',NULL,'2023-10-19 22:07:31',NULL,'2023-10-19 16:37:31',NULL);

INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('13','6','videoes/1697733608620.mp4','CPC Video 4','mp4','Civil Procedure Code','0','1',NULL,'2023-10-19 22:10:10',NULL,'2023-10-19 16:40:10',NULL);
INSERT INTO note (note_id,subject_id,note_name,note_path,note_desc,note_extension,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('6','6','CPC Notes','notes/1697733759279.pdf','Civil Procedure Code','pdf','0','1',NULL,'2023-10-12 14:08:55',NULL,'2023-10-19 22:12:39',NULL);
INSERT INTO note (note_id,subject_id,note_name,note_path,note_desc,note_extension,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('7','7','Title','notes/1697100258367.pdf','Sub Title','pdf','0','1',NULL,'2023-10-12 14:14:18',NULL,'2023-10-12 08:44:18',NULL);
INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('38','6','Which of the following deals with the statement and production of evidence in the Code of Civil Procedure?','1','Order 18, Rule 2','Order 12, Rule 5','Order 14, Rule 20','Order 18, Rule 2','Order 11, Rule 7','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('39','6','Which of the following deals with the right to challenge non-appealable orders in appeal against decrees in the Code of Civil Procedure?','1','Order 43, Rule 1A','Order 43, Rule 1A','Order 14, Rule 20','Order 18, Rule 2','Order 11, Rule 7','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('40','6','In order for that a decision in a former suit may operate as res judicata, the court which may decide that suit must have been?
I. A civil court of competent jurisdiction

II. A court of exclusive jurisdiction

III. A court of concurrent jurisdiction competent to try the subsequent suit

IV. A court of limited jurisdiction competent to try the issue raised in the subsequent suit','1','All of these','Either I or III','Either II or III','Either III or IV','All of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('41','6','In transaction for transfer or delivery of the property attached, where the contract is executed and registered before attachment, the mischief of sub-s (1) shall not apply. However in which of the following situation it applies?','1','Both (A) and (B)','Where the property is transferred and registered after attachment','Where the property is transferred before attachment but registration takes place after the attachment','Both (A) and (B)','None of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('42','6','The court to amend a decree is the court that passed it. Where an appeal is preferred from a decree of a court of first instance the Appellate Court may:','1','Either (A) or (B)','Dismiss the appeal under O. 41, r 11(1), without issuing any notice to the respondents','Confirm, reverse or vary the decree of the court of first instance (O. 41, r 32)','Either (A) or (B)','None of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('43','6','Which of the following tests are to be applied in cases where the plea of bar of the suit under O. 2, r 2 is raised?','1','all of these','Whether the cause of action in the previous suit and that in the subsequent suit are identical','Whether the relief claimed in the subsequent suit could have been given in the previous suit on the basis of the pleadings filed in that suit','Whether the plaintiff omitted to sue for a particular relief on the cause of action which had been disclosed in the previous suit','all of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('44','6','An order under O. 33, r 11 directing the pauper plaintiff to pay the Court-fees can only be made in which of the following cases?

I. Where the plaintiff fails in the suit

II. Where the plaintiff is dispaupered under r 9

III. Where the suit is withdrawn

IV. Where the suit is dismissed under the circumstances specified in cl. (a) or cl. (b)','1','all of the above','I, III, IV','II, IV','III, IV','all of the above','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('45','6','The words it appears to the Central Government which is the consenting authority, makes it clear that:','1','The decision granting the consent is final','The decision granting the consent is open to question by the court','The decision granting the consent is final','Either (A) or (B)','None of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('46','6','The word resides used in s. 19 of the Code of Civil Procedure means:','1','Natural persons','Natural persons','Companies','Tort','all of the above','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('47','6','Bar to further suit is dealt under which of the following in the Code of Civil Procedure?','1','Section 12','Section 11','Section 12','Section 16','Section 36','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('48','6','Which of the following deals with the transfer of decree in the Code of Civil Procedure?','1','Section 39','Section 41','Section 36','Section 49','Section 39','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('49','6','Which of the following has been repealed by s. 7 of the Code of Civil Procedure (Amendment) Act 66 of 1956 in the Code of Civil Procedure?

I. Section 68

II. Section 69

III. Section 70

IV. Section 71

V. Section 72','1','All of them','I, III, IV','II, III, V','Ill, IV, V','All of them','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('50','6','No order under section 47 to be refused or modified unless decision of the case is prejudicially affected under which of the following in the Code of Civil Procedure?','1','Section 99A','Section 90A','Section 95A','Section 99A','Section 101B','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);
INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('14','7','question b','1','b','a','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('15','7','question c','1','c','a','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('16','7','question d','1','d','a','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('17','7','question aa','1','aa','aa','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('18','7','question bb','1','bb','a','bb','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

```
