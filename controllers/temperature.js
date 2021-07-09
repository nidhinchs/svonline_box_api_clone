const {exec} = require('child_process');

exports.get_temperature = function (req, res) {
    exec(`sudo vcgencmd measure_temp`, (err, stdout, stderr) => {
        if (err) {
            console.error(`exec error: ${err}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
        console.log(`stderr: ${stderr}`);
        res.json({result:stdout});
    });
}