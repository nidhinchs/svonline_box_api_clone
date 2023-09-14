var express = require("express");

var router = express.Router();

const syncData = require("../controllers/syncData");
const download = require("../controllers/download_file");
const add_data_to_box = require("../controllers/add_data_to_box");
const temp = require("../controllers/temperature");

/* GET home page. */
router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});
router.get("/_health", (req, res) => {
  res.status("200").send("ok");
});
//admin data
router.get("/api/check_connection", syncData.check_connection);
router.get("/api/download", download.download);
router.get("/api/get_server_courses", add_data_to_box.get_courses);

router.get("/api/disable_access_point", temp.disable_access_point);
router.get("")

module.exports = router;
