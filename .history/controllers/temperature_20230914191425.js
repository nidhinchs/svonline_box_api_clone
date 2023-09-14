const { exec } = require("child_process");
let common = require("./common");

exports.get_temperature = function (req, res) {
  exec(`sudo vcgencmd measure_temp`, (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    console.log(`stderr: ${stderr}`);
    res.json({ result: stdout });
  });
};

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
      res.json({ result: stdout });
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
    res.json({ result: stdout });
  });
};

exports.add_box_details = function (req, res) {
  let item = req.body;
  console.log(item);

  common.select_first("select * from hbt limit 1", function (call1) {
    if (call1.code == 200) {
      if (
        item.device_id != undefined &&
        call1.result.device_name != undefined
      ) {
        if (item.device_id == call1.result.device_name) {
          let obj = {
            f_id: item.f_id,
            box_id: item.device_id,
            f_name: item.f_name,
            f_phone: item.f_phone,
            f_email: item.f_email,
            f_address: item.f_address,
            f_state: item.f_state,
            f_city: item.f_city,
            f_token: item.f_token,
            f_username: item.f_username,
            f_password: item.f_password,
            is_active: 1,
            is_delete: 0,
            created_by: 1,
            created_date: getCurrentDateTime(),
            modified_by: 1,
            modified_date: getCurrentDateTime()
          };

          common.insert(obj, "franchise", function (call2) {
            res.json(call2);
          });
        } else {
          res.json({
            code: "400",
            status: "error",
            error: "Device does not match"
          });
        }
      } else {
        res.json({
          code: "400",
          status: "error",
          error: "Device id does not found"
        });
      }
    } else {
      res.json({
        code: "400",
        status: "error",
        error:
          "This box does not having data for checking temperature and cpu usage. Please connect to the admin for verify."
      });
    }
  });
};

exports.disable_access_point1 = function (req, res) {
  const { spawn } = require("child_process");

  // Replace 'pythonScript.py' with the path to your Python script
  const pythonScriptPath = "home/smit/public/Networks/access.py";

  // Run the Python script
  const pythonProcess = spawn("python", [pythonScriptPath]);

  // Handle the output of the Python script (stdout and stderr)
  pythonProcess.stdout.on("data", (data) => {
    console.log(`Python stdout: ${data}`);
  });

  pythonProcess.stderr.on("data", (data) => {
    console.error(`Python stderr: ${data}`);
  });

  // Handle the exit of the Python script
  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);
  });
};
