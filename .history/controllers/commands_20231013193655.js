const fs = require("fs");
const wpaConfigPath = "/etc/wpa_supplicant/wpa_supplicant.conf";

exports.add_wifi_cred = function (req, res) {
  const wifiCredentials = req.body;

  console.log(wifiCredentials);

  const wifiSSID = wifiCredentials.ssid;
  const wifiPassword = wifiCredentials.password;

  // Check if the wpa_supplicant configuration file exists
  if (fs.existsSync(wpaConfigPath)) {
    console.log("wpa_supplicant configuration file exists. Rewriting...");
  }

  // Update the wpa_supplicant configuration
  const wpaSupplicantConfig = `
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="${wifiSSID}"
    psk="${wifiPassword}"
}
`;

  // Write or rewrite the configuration to the file
  fs.writeFile(wpaConfigPath, wpaSupplicantConfig, (err) => {
    if (err) {
      console.error("Error writing wpa_supplicant configuration:", err);
    } else {
      // Restart the Wi-Fi interface

      const { exec } = require("child_process");
      temp.disable_access_point1(req, res);
      //   exec("sudo ifdown wlan0 && sudo ifup wlan0", (error, stdout, stderr) => {
      //     if (error) {
      //       console.error("Error restarting Wi-Fi:", error);
      //     } else {
      //       console.log("Wi-Fi restarted successfully.");
      //     }
      //   });
    }
  });
};

exports.shut_down = function (req, res) {
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

exports.reboot = function (req, res) {
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
