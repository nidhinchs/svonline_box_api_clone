const axios = require("axios");
const fs = require("fs");
const path = require("path");

exports.download = async function (req, res) {
  const remoteUrl = req.query.remoteUrl; // Get the remote URL from query parameter
  const fileName = path.basename(remoteUrl); // Extract file name from the URL

  try {
    const response = await axios.get(remoteUrl, { responseType: "stream" });

    // Set appropriate headers for the response
    res.setHeader("Content-Disposition", `attachment; filename=${fileName}`);
    res.setHeader("Content-Type", "application/octet-stream");

    // Stream the remote file to the response
    response.data.pipe(res);
  } catch (error) {
    console.error("Error downloading remote file:", error.message);
    res.status(500).send("Error downloading remote file");
  }
};
