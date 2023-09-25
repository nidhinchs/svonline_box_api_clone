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
const add_data_to_box = require("../controllers/add_data_to_box");

/* GET home page. */
router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});

router.get("/_health", (req, res) => {
  res.status(200).send("ok");
});
// router.get("/_health", (req, res) => {
//   res.json({
//     status: "success",
//     code: "200"
//   });
//   // res.status(200).send("ok");
// });

//admin data
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
router.get("/api/get_temperature", temp.get_temperature);
router.get("/api/reboot", temp.reboot);
// router.post('/upload',video.upload_file);

//student data
router.get("/api/get_quiz", quiz.get_quiz);
router.get("/api/get_course", quiz.get_course);
router.get("/api/get_subject", quiz.get_subject);
router.get("/api/get_video", quiz.get_video);
router.get("/api/get_note", quiz.get_note);
router.post("/api/add_result", quiz.add_result);
router.post("/api/add_progress", quiz.add_progress);
router.get("/api/get_result", quiz.get_result);
router.get("/api/get_result_detail", quiz.get_result_detail);

//student table

router.get("/api/login", student.login);
router.get("/api/signout", student.signout);
router.post("/api/f_login", student.f_login);
router.get("/api/get_profile", student.get_profile);
router.get("/api/check_student_status", student.check_student_status);

router.post("/api/add_student", student.add_student);
router.post("/api/add_student_attendance", student.add_student_attendance);
router.post("/api/call_reset_device", student.call_reset_device);
router.get("/api/get_student", student.get_student);

// admin app apis

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

router.post("/api/add_box_details", temp.add_box_details);

module.exports = router;
