const fs = require("fs");
let common = require("./common");
let config = require("../config/config").config();
let admin_common = require("./admin_common");

exports.download_files = function (req, res) {
  const fs = require("fs");

  //   const urls = ["url 1", "url 2"];
  let query = "select * from video where subject_id = " + req.query.subject_id;

  admin_common.selectAll(query, function (callback) {
    if (callback.code == 200) {
      //   console.log(callback.result);
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
            item.ip_address,
          ]),
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

        // res.json(call1);
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
      // let downloadFolderPath = "../public/video";
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
          recursive: true,
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

  // urls.forEach(async (url) => {
  //   await downloadFile(url[0]);
  //   downloadedFiles++;
  //   console.log(`${downloadedFiles}/${urls.length} downloaded`);
  //   if (downloadedFiles === urls.length) {
  //     console.log("downloadedFiles complete");
  //     callback({ code: 200, status: "success", result: urls.length });
  //   }
  // });
}

exports.copy_file1 = function (req, res) {
  var client = require("scp2");

  client.scp(
    {
      host: config.remote_server.host,
      username: config.remote_server.username,
      password: config.remote_server.password,
      path: "/home/test/",
    },
    "./uploads/",
    function (err) {
      if (err) {
        console.log(err);
        res.send(err);
        // res.end();
      } else {
        res.send("Done");
        // res.end();
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
      password: config.remote_server.password,
      // privateKey: fs.readFileSync('./key.pem'),
      // passphrase: 'your key passphrase',
    });
    console.log("start uploading");
    await client.downloadDir("/home/test/uploads", "./uploads");

    client.close(); // remember to close connection after you finish
    callback("done");
  } catch (e) {
    console.log(e);
    callback(e);
  }
}
