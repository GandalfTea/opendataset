"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
exports.router = void 0;
var db_1 = require("../db");
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
router.get("/:dsid/details", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var dsid, ret, ret;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                dsid = req.params.dsid;
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT ds_id FROM ds_metadata WHERE ds_name='".concat(dsid, "';"))];
            case 1:
                ret = _a.sent();
                dsid = ret["rows"][0]["ds_id"];
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT * FROM ds_frontend WHERE ds_id='".concat(dsid, "'"))];
            case 2:
                ret = _a.sent();
                console.log(ret);
                res.status(200);
                res.set("Access-Control-Allow-Origin", "*");
                res.send(JSON.stringify(ret));
                return [2 /*return*/];
        }
    });
}); });
// UPDATE FRONTEND
router.patch("/:dsid/frontend/description", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var dsid, ret, new_des, ret;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                console.log("HERE");
                dsid = req.params.dsid;
                if (!(dsid instanceof String || typeof dsid === "string")) return [3 /*break*/, 2];
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT ds_id FROM ds_metadata WHERE ds_name='".concat(dsid, "';"))];
            case 1:
                ret = _a.sent();
                dsid = ret["rows"][0]["ds_id"];
                _a.label = 2;
            case 2:
                new_des = req.body["description"];
                console.log(Object.keys(req.body));
                return [4 /*yield*/, (0, db_1.queryDB)("UPDATE ds_frontend SET description='".concat(new_des, "' WHERE ds_id=").concat(dsid, ";"))];
            case 3:
                ret = _a.sent();
                console.log(ret);
                res.status(200);
                res.send("Hello");
                return [2 /*return*/];
        }
    });
}); });
// EDIT
// DELETE
router["delete"]("/:dsid", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var dsid, dsname, ret, ret, ret, ret;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                dsid = req.params.dsid;
                if (!(dsid instanceof String || typeof dsid === "string")) return [3 /*break*/, 2];
                dsname = dsid;
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT ds_id FROM ds_metadata WHERE ds_name='".concat(dsid, "';"))];
            case 1:
                ret = _a.sent();
                dsid = ret["rows"][0]["ds_id"];
                return [3 /*break*/, 4];
            case 2: return [4 /*yield*/, (0, db_1.queryDB)("SELECT ds_name FROM ds_metadata WHERE ds_id='".concat(dsid, "';"))];
            case 3:
                ret = _a.sent();
                _a.label = 4;
            case 4: return [4 /*yield*/, (0, db_1.queryDB)("DELETE FROM ds_metadata WHERE ds_id='".concat(dsid, "';"))];
            case 5:
                ret = _a.sent();
                return [4 /*yield*/, (0, db_1.queryDB)("DELETE FROM ds_frontend WHERE ds_id='".concat(dsid, "';"))];
            case 6:
                ret = _a.sent();
                console.log("\n\n\n", ret);
                res.status(204);
                res.send("Hello");
                return [2 /*return*/];
        }
    });
}); });
