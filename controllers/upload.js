const util = require("util");
const multer = require("multer");
const maxSize_for_note = 2 * 1024 * 1024;
const maxSize_for_video = 200 * 1024 * 1024;
global.notes_path = "public/notes";
global.videoes_path = "public/videoes";

let storage_for_file = multer.diskStorage({
  destination: (req, file, cb) => {
    // console.log(req);
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
    // console.log(req);
    cb(null, videoes_path);
  },
  filename: (req, file, cb) => {
    console.log(file.originalname);
    cb(null, file.originalname);
  },
});

exports.uploadVideo = multer({
  storage: storage_for_video,
  limits: { fileSize: maxSize_for_video },
});
