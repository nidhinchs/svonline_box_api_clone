const fs = require('fs');
let common = require('./common');
let admin_common = require('./admin_common');

const multer = require('multer');

const upload_video = require("./video_upload.js");


var storage = multer.diskStorage({
    destination: function (req, file, cb) {

        // Uploads is the Upload_folder_name
        cb(null, "uploads")
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + "-" + Date.now() + ".jpg")
    }
});

// Define the maximum size for uploading
// picture i.e. 1 MB. it is optional
const maxSize = 1 * 1000 * 1000;

var upload = multer({
    storage: storage,
    limits: {fileSize: maxSize},
    fileFilter: function (req, file, cb) {

        // Set the filetypes, it is optional
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

// mypic is the name of file attribute
}).single("mypic");


exports.upload_video = function (req, res) {
    upload(req, res, function (err) {
        if (err) {
            // ERROR occured (here it can be occured due
            // to uploading image of size greater than
            // 1MB or uploading different file type)
            res.send(err)
        } else {
            // SUCCESS, image successfully uploaded
            res.send("Success, Image uploaded!")
        }
    });
}

/*
exports.upload_file = function(req,res){
    if (req.files) {
        console.log(req.files);
        var file = req.files.file;
        var filename = file.name;
        console.log(filename);

        file.mv('./uploads/' +filename, function (err) {
            if (err) {
                res.send(err);
            } else {
                res.send({message: "file uploaded"});
            }
        })

    }
}*/
