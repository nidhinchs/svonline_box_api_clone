const fs = require('fs');
let common = require('./common');
let config = require('../config/config').config();
let admin_common = require('./admin_common');

exports.copy_file1 = function (req, res) {

    var client = require('scp2');

    client.scp({
        host: config.remote_server.host,
        username: config.remote_server.username,
        password: config.remote_server.password,
        path: '/home/test/'
    }, './uploads/', function (err) {

        if (err) {
            console.log(err);
            res.send(err);
            // res.end();
        } else {
            res.send("Done");
            // res.end();
        }
    })


}

exports.copy_file = function (req, res) {

    const scp = require('node-scp');

    test(scp, function (callback) {
        res.send(callback);
    });

}

async function test(scp,callback) {
    try {
        const client = await scp({
            host: config.remote_server.host,
            port: 22,
            username: config.remote_server.username,
            password: config.remote_server.password,
            // privateKey: fs.readFileSync('./key.pem'),
            // passphrase: 'your key passphrase',
        })
        await client.uploadDir('./uploads', '/home/test/uploads')

        client.close() // remember to close connection after you finish
        callback("done");
    } catch (e) {
        console.log(e)
        callback(e);
    }
}

