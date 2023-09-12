#!/usr/bin/env node

/**
 * Module dependencies.
 */
let config = require("./config/config").config();
var createError = require("http-errors");
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
const upload = require("express-fileupload");

// Firebase App (the core Firebase SDK) is always required and
// must be listed before other Firebase SDKs
var firebase = require("firebase/app");
const cors = require("cors");

// Add the Firebase products that you want to use
require("firebase/auth");
require("firebase/firestore");

var indexRouter = require("./routes/index");
var syncDataRouter = require("./routes/sync_data");

var app = express();
app.use(cors());

process.env.TZ = "Asia/Kolkata";

// view engine setup
app.engine("pug", require("pug").__express);
// app.set('views', path.join(__dirname, 'views'));
//if we create exe file then this line is required with pkg
app.set("views", path.join(process.cwd(), config.base_path + "views"));
// app.set('views', __dirname + '/views');
app.set("view engine", "pug");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(process.cwd(), config.base_path + "public")));

app.use("/", indexRouter);
app.use("/", syncDataRouter);
app.use(
  upload({
    limits: { filesize: 50 * 1024 * 1024 }
  })
);
app.get("/upload", function (req, res) {
  res.sendFile(__dirname + "/index.html");
});
app.post("/upload", (req, res) => {
  if (req.files) {
    console.log(req.files);
    var file = req.files.file;
    var filename = file.name;
    console.log(filename);

    file.mv("G:/uploads/" + filename, function (err) {
      if (err) {
        res.send(err);
      } else {
        res.send({ message: "file uploaded" });
      }
    });
  }
});

app.all("/*", function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "http://localhost:63342");
  res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
  res.header(
    "Access-Control-Allow-Headers",
    "X-Requested-With,     Content-Type"
  );
  next();
});

// indexRouter.initialize(app);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

// var app = require('./app');
var debug = require("debug")("employeeattandance:server");
var http = require("http");

/**
 * Get port from environment and store in Express.
 */
const hostname = "0.0.0.0";
var port = normalizePort(process.env.PORT || "3002");
app.set("port", port);

/**
 * Create HTTP server.
 */

var server = http.createServer(app);

const cron = require("node-cron");
cron.schedule("*/15 * * * *", function () {
  // cron.schedule('* * * * * *', function() {
  console.log("running a check temperature of the device");
  const site = require("./controllers/temperature");
  site.check_temperature(function (callback) {
    //res.json(callback);
  });
});

/**
 * Listen on provided port, on all network interfaces.
 */
server.listen(port, hostname, () =>
  console.log(`Hello world app listening on port ${port}!`)
);
// server.listen(port);
server.on("error", onError);
server.on("listening", onListening);

/**
 * Normalize a port into a number, string, or false.
 */

function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}

/**
 * Event listener for HTTP server "error" event.
 */

function onError(error) {
  if (error.syscall !== "listen") {
    throw error;
  }

  var bind = typeof port === "string" ? "Pipe " + port : "Port " + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case "EACCES":
      console.error(bind + " requires elevated privileges");
      process.exit(1);
      break;
    case "EADDRINUSE":
      console.error(bind + " is already in use");
      process.exit(1);
      break;
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */

function onListening() {
  var addr = server.address();
  var bind = typeof addr === "string" ? "pipe " + addr : "port " + addr.port;
  debug("Listening on " + bind);
}

module.exports = {
  app
};
