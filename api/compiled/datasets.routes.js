"use strict";
exports.__esModule = true;
exports.router = void 0;
var express = require("express");
var router = express.Router();
exports.router = router;
// GET
router.get("/:dsid", function (req, res) {
    var dsid = req.params.dsid;
    res.status = 302;
    res.send("GET Dataset with UUID ".concat(dsid));
});
router.get("/:dsid/contributions/:hash", function (req, res) {
    var ds = req.params.dsid["uuid"];
    var hash = req.params.hash;
    res.status = 302;
    res.send("GET contribution ".concat(hash, " for dataset ").concat(ds, "."));
});
