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
        res1.json({ status: res.statusCode, code: "200" });
      } else {
        reject(res.statusCode);
        res1.json({ status: res.statusCode, code: "400" });
        console.log("get error" + res.statusCode);
      }
    });
  });
}


exports.get_courses = function (req,res){
    let query = 
}
