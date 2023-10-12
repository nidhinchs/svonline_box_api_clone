const { exec } = require("child_process");
let common = require("./common");

// exports.get_temperature = function (req, res) {
//   exec(`sudo vcgencmd measure_temp`, (err, stdout, stderr) => {
//     if (err) {
//       console.error(`exec error: ${err}`);
//       return;
//     }
//     console.log(`stdout: ${stdout}`);
//     console.log(`stderr: ${stderr}`);
//     res.json({ result: stdout });
//   });
// };

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
      // res.json({ result: stdout });
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
    // res.json({result:stdout.split("=")[1].split("'")[0]});
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
    // res.json({ result: stdout });
  });
};

exports.disable_access_point1 = function (req, res) {
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

exports.enable_access_point = function (req, res) {
  const { spawn } = require("child_process");

  // Replace 'pythonScript.py' with the path to your Python script
  const pythonScriptPath = "../Public/Networks/access.py";

  // Run the Python script
  const pythonProcess = spawn("python", [pythonScriptPath]);

  // Handle the output of the Python script (stdout and stderr)
  pythonProcess.stdout.on("data", (data) => {
    console.log(`Python stdout: ${data}`);
    // res.json({
    //   code: "200",
    //   status: "success",
    //   result: `Python stdout: ${data}`
    // });
  });

  pythonProcess.stderr.on("data", (data) => {
    // res.json({
    //   code: "400",
    //   status: "error",
    //   error: `Python stderr: ${data}`
    // });
    console.error(`Python stderr: ${data}`);
  });

  // Handle the exit of the Python script
  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);
  });
};
