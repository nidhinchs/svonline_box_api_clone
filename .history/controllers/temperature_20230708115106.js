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

  common.select_first("select * from hbt limit 1", function (call1) {
    if (call1.code == 200) {
      if (
        item.device_name != undefined &&
        call1.result.device_name != undefined
      ) {
        if(item.device_name == call1.result.device_name){
          let obj = {
            f_id : item.f_id,
            
          }

        }else{
          res.json({
            code: "400",
            status: "success",
            error: "Device does not match"
          });
        }
      }
    } else {
      res.json({
        code: "400",
        status: "success",
        error: "There is no data found which can verify device name."
      });
    }
  });
};
