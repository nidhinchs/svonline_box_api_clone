var express = require("express");

var router = express.Router();

const syncData = require("../controllers/syncData");
const download = require("../controllers/download_file");

/* GET home page. */
router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});
router.get("/_health", (req, res) => {
  res.status(200).send("ok");
});
//admin data
router.get("/api/check_connection", syncData.check_connection);
router.get("/api/download", download.download);
router.get("/api/get_server_courses", download.get_courses);

module.exports = router;
