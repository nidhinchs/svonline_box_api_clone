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
  // exec(`sudo reboot`, (err, stdout, stderr) => {
  //   if (err) {
  //     console.error(`exec error: ${err}`);
  //     return;
  //   }
  //   console.log(`stdout: ${stdout}`);
  //   console.log(`stderr: ${stderr}`);
  //   res.json({ code: "200", status: "success" });
  // });

  const { spawn } = require("child_process");

  // Replace 'pythonScript.py' with the path to your Python script
  const pythonScriptPath = "../Public/Networks/connect.py";

  // Run the Python script
  const pythonProcess = spawn("python", [pythonScriptPath]);

  // Handle the output of the Python script (stdout and stderr)
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

  // Handle the exit of the Python script
  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);
  });
};
