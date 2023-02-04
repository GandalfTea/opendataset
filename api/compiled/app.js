"use strict";
exports.__esModule = true;
require('dotenv').config();
var assert = require("assert");
var express = require("express");
var session = require("express-session");
var pgSession = require("connect-pg-simple")(session);
// Setup
var app = express();
var PORT = 3000;
var DEBUG = false;
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
var store = new pgSession({
    conString: "postgres://".concat(process.env.PGUSER, ":").concat(process.env.PGPASSWORD, "@").concat(process.env.PGHOST, ":").concat(process.env.PGPORT, "/").concat(process.env.PGDATABASE)
});
app.use(session({
    store: store,
    secret: "catsridingbikesonspikeslikereichs",
    saveUninitialized: false,
    resave: false,
    cookie: {
        secure: false,
        maxAge: 1000 * 60 * 60
    }
}));
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
app.use("/ds", datasets_routes_1.router);
app.use("/login", login_routes_1.router);
app.listen(PORT, function () {
    console.log("Listening on port: ".concat(PORT));
});
