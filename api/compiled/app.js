"use strict";
exports.__esModule = true;
var assert = require("assert");
var express = require("express");
var app = express();
var PORT = 3000;
var DEBUG = false;
// Setup
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.get("/", function (req, res) {
    res.status = 200;
    res.send("Hello");
});
// Routes
var create_routes_1 = require("./routes/create.routes");
var users_routes_1 = require("./routes/users.routes");
var datasets_routes_1 = require("./routes/datasets.routes");
var login_routes_1 = require("./routes/login.routes");
app.use("/create", create_routes_1.router);
app.use("/user", users_routes_1.router);
app.use("/dataset", datasets_routes_1.router);
app.use("/login", login_routes_1.router);
app.listen(PORT, function () {
    console.log("Listening on port: ".concat(PORT));
});
