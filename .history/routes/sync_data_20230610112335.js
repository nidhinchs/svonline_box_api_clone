var express = require("express");

var router = express.Router();

const d = require("../controllers/item");
const quiz = require("../controllers/quiz");
const student = require("../controllers/student");
const copyFile = require("../controllers/copyFile");
const video = require("../controllers/video");
const db = require("../controllers/DbController");
const temp = require("../controllers/temperature");
const uploadFile = require("../controllers/upload");

/* GET home page. */
router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});
router.get("/_health", (req, res) => {
  res.status(200).send("ok");
});
//admin data
router.get("/api/check_connection", db.check_connection);


module.exports = router;
