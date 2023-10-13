exports.add_wifi_cred = function (req, res) {
  const fs = require("fs");

  const wifiCredentials = req.body;
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
      exec("sudo ifdown wlan0 && sudo ifup wlan0", (error, stdout, stderr) => {
        if (error) {
          console.error("Error restarting Wi-Fi:", error);
        } else {
          console.log("Wi-Fi restarted successfully.");
        }
      });
    }
  });
};
