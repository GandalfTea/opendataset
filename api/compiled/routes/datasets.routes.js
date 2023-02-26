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
var utils_1 = require("../utils");
var path = require("path");
var fs = require('fs');
require("dotenv").config();
var express = require("express");
var router = express.Router();
exports.router = router;
// TODO: Cache recent downloads
router.get("/:dsid", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _start, rp, ret, e_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                if (process.env.DEBUG) {
                    process.stdout.write("\nGET * ".concat(req.params.dsid));
                    _start = process.hrtime.bigint();
                }
                return [4 /*yield*/, (0, utils_1.ds_exists)(req.params.dsid)];
            case 1:
                if (!_a.sent()) return [3 /*break*/, 7];
                rp = path.resolve(__dirname, '../../tmp/', "".concat(req.params.dsid, "-") + Date.now() + ".csv");
                return [4 /*yield*/, (0, db_1.queryDB)("COPY ".concat(req.params.dsid, " TO '").concat(rp, "' WITH DELIMITER ',' CSV HEADER;"))
                    // TODO: \COPY doesn't work, this is an empty file
                ];
            case 2:
                ret = _a.sent();
                _a.label = 3;
            case 3:
                _a.trys.push([3, 5, , 6]);
                return [4 /*yield*/, fs.promises.writeFile(rp, "demo data for a demo world")];
            case 4:
                _a.sent();
                return [3 /*break*/, 6];
            case 5:
                e_1 = _a.sent();
                console.log(e_1);
                return [3 /*break*/, 6];
            case 6:
                res.download(rp, function (e) { return __awaiter(void 0, void 0, void 0, function () {
                    var e_2, _end;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0:
                                if (!e) return [3 /*break*/, 1];
                                console.log(e);
                                return [3 /*break*/, 6];
                            case 1:
                                _a.trys.push([1, 4, , 5]);
                                if (!fs.existsSync(rp)) return [3 /*break*/, 3];
                                return [4 /*yield*/, fs.promises.unlink(rp)];
                            case 2:
                                _a.sent();
                                _a.label = 3;
                            case 3: return [3 /*break*/, 5];
                            case 4:
                                e_2 = _a.sent();
                                console.log(e_2);
                                return [3 /*break*/, 5];
                            case 5:
                                if (process.env.DEBUG) {
                                    _end = process.hrtime.bigint();
                                    process.stdout.write("\t success \t ".concat((Number(_end - _start) * 1e-6).toFixed(2), "ms"));
                                }
                                _a.label = 6;
                            case 6: return [2 /*return*/];
                        }
                    });
                }); });
                return [3 /*break*/, 8];
            case 7:
                if (process.env.DEBUG)
                    process.stdout.write("\tERROR \t dataset does not exits.");
                res.status(404);
                res.send("Dataset not found.");
                _a.label = 8;
            case 8: return [2 /*return*/];
        }
    });
}); });
// Get random percentage from dataset
router.get("/:dsid/p/:percentage", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _start, rp, req_num, ret, num_entries, used_idx, randidx, ret, e_3;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                if (process.env.DEBUG) {
                    process.stdout.write("\nGET ".concat(req.params.percentage, "% ").concat(req.params.dsid));
                    _start = process.hrtime.bigint();
                }
                return [4 /*yield*/, (0, utils_1.ds_exists)(req.params.dsid)];
            case 1:
                if (!_a.sent()) return [3 /*break*/, 8];
                rp = path.resolve(__dirname, '../../tmp/', "".concat(req.params.dsid, "-") + Date.now() + ".csv");
                req_num = req.params.percentage / 100;
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT num_entries FROM ds_frontend WHERE ds_id=$1;", [req.params.dsid])];
            case 2:
                ret = _a.sent();
                num_entries = 0;
                num_entries = 5000; // not yet in db
                used_idx = new Set();
                while (used_idx.size < num_entries * req_num) {
                    randidx = Math.floor(Math.random() * num_entries);
                    used_idx.add(randidx);
                }
                return [4 /*yield*/, (0, db_1.queryDB)("COPY (SELECT * FROM ".concat(req.params.dsid, " WHERE ds_id in \n\t\t\t\t\t\t\t\t\t\t\t\t\t  (").concat(Array.from(used_idx), ")) TO ").concat(rp, " WITH DELIMITER ',' CSV HEADER;"))];
            case 3:
                ret = _a.sent();
                _a.label = 4;
            case 4:
                _a.trys.push([4, 6, , 7]);
                return [4 /*yield*/, fs.promises.writeFile(rp, "")];
            case 5:
                _a.sent();
                return [3 /*break*/, 7];
            case 6:
                e_3 = _a.sent();
                console.log(e_3);
                return [3 /*break*/, 7];
            case 7:
                res.download(rp, function (e) { return __awaiter(void 0, void 0, void 0, function () {
                    var e_4, _end;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0:
                                if (!e) return [3 /*break*/, 1];
                                console.log(e);
                                return [3 /*break*/, 6];
                            case 1:
                                _a.trys.push([1, 4, , 5]);
                                if (!fs.existsSync(rp)) return [3 /*break*/, 3];
                                return [4 /*yield*/, fs.promises.unlink(rp)];
                            case 2:
                                _a.sent();
                                _a.label = 3;
                            case 3: return [3 /*break*/, 5];
                            case 4:
                                e_4 = _a.sent();
                                console.log(e_4);
                                return [3 /*break*/, 5];
                            case 5:
                                if (process.env.DEBUG) {
                                    _end = process.hrtime.bigint();
                                    process.stdout.write("\t success \t ".concat((Number(_end - _start) * 1e-6).toFixed(2), "ms"));
                                }
                                _a.label = 6;
                            case 6: return [2 /*return*/];
                        }
                    });
                }); });
                return [3 /*break*/, 9];
            case 8:
                if (process.env.DEBUG)
                    process.stdout.write("\tERROR \t dataset does not exits.");
                res.status(404);
                res.send("Dataset not found.");
                _a.label = 9;
            case 9: return [2 /*return*/];
        }
    });
}); });
// Get a sample of first 50 entries
router.get("/:dsid/sample", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var _start, ret, ret_1, _end;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                if (process.env.DEBUG) {
                    process.stdout.write("\nGET SAMPLE ".concat(req.params.dsid));
                    _start = process.hrtime.bigint();
                }
                if (!(0, utils_1.ds_exists)(req.params.dsid)) return [3 /*break*/, 4];
                if (!Number.isInteger(Number(req.params.dsid))) return [3 /*break*/, 2];
                return [4 /*yield*/, (0, db_1.queryDB)("select ds_name from ds_metadata where ds_id=$1;", [req.params.dsid])];
            case 1:
                ret_1 = _a.sent();
                req.params.dsid = ret_1.rows[0].ds_name;
                _a.label = 2;
            case 2: return [4 /*yield*/, (0, db_1.queryDB)("SELECT row_to_json(".concat(req.params.dsid, ") FROM ").concat(req.params.dsid, " LIMIT 50;"))];
            case 3:
                ret_1 = _a.sent();
                res.status(200);
                res.send(ret_1);
                if (process.env.DEBUG) {
                    _end = process.hrtime.bigint();
                    process.stdout.write("\t success \t ".concat((Number(_end - _start) * 1e-6).toFixed(2), "ms"));
                }
                return [3 /*break*/, 5];
            case 4:
                process.stdout.write("\t ERROR \t Dataset does not exist");
                res.status(404);
                res.send("Dataset not found.");
                _a.label = 5;
            case 5: return [2 /*return*/];
        }
    });
}); });
router.get("/:dsid/contributions/:hash", function (req, res) {
    var ds = req.params.dsid["uuid"];
    var hash = req.params.hash;
    res.status = 302;
    res.send("GET contribution ".concat(hash, " for dataset ").concat(ds, "."));
});
/* GET metadata about dataset */
router.get("/:dsid/details", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var dsid, query, ret, ret, ret;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                dsid = req.params.dsid;
                query = req.query.q;
                if (!(0, utils_1.ds_exists)(dsid)) return [3 /*break*/, 6];
                if (!!Number.isInteger(Number(dsid))) return [3 /*break*/, 2];
                return [4 /*yield*/, (0, db_1.queryDB)("select ds_id from ds_metadata where ds_name=$1;", [dsid])];
            case 1:
                ret = _a.sent();
                dsid = ret.rows[0].ds_id;
                _a.label = 2;
            case 2:
                if (!(query != null)) return [3 /*break*/, 4];
                if (!['description', 'readme', 'num_contributors', 'num_entries', 'licence', 'contribution_guidelines'].includes(query)) return [3 /*break*/, 4];
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT ".concat(query, " FROM ds_frontend WHERE ds_id=$1"), [dsid])];
            case 3:
                ret = _a.sent();
                res.status(200);
                res.send(JSON.stringify(ret.rows[0]));
                return [2 /*return*/];
            case 4: return [4 /*yield*/, (0, db_1.queryDB)("SELECT * FROM ds_frontend WHERE ds_id=$1", [dsid])];
            case 5:
                ret = _a.sent();
                res.status(200);
                res.send(JSON.stringify(ret.rows[0]));
                _a.label = 6;
            case 6: return [2 /*return*/];
        }
    });
}); });
// UPDATE FRONTEND
router.patch("/:dsid/details", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var query, dsid, ret, new_des, ret;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                query = req.query.q;
                dsid = req.params.dsid;
                if (!(query != null && dsid != null)) return [3 /*break*/, 4];
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT ds_id FROM ds_metadata WHERE ds_name=$1", [dsid])];
            case 1:
                ret = _a.sent();
                try {
                    dsid = ret.rows[0].ds_id;
                }
                catch (e) {
                    console.log(e);
                }
                new_des = req.body['data'];
                if (!['description', 'readme', 'num_contributors', 'num_entries', 'licence', 'contribution_guidelines'].includes(query)) return [3 /*break*/, 3];
                return [4 /*yield*/, (0, db_1.queryDB)("UPDATE ds_frontend SET ".concat(query, "=$1 WHERE ds_id=$2"), [new_des, dsid])];
            case 2:
                ret = _a.sent();
                _a.label = 3;
            case 3:
                res.status(200);
                res.send("Done.");
                _a.label = 4;
            case 4: return [2 /*return*/];
        }
    });
}); });
// EDIT
// DELETE
router["delete"]("/:dsid", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var dsid, ret, ret, ret;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                dsid = req.params.dsid;
                if (!!Number.isInteger(Number(dsid))) return [3 /*break*/, 2];
                return [4 /*yield*/, (0, db_1.queryDB)('SELECT ds_id FROM ds_metadata WHERE ds_name=$1;', [dsid])];
            case 1:
                ret = _a.sent();
                if (ret.rowCount === 0) {
                    res.status(404);
                    res.send("Dataset not found.");
                    return [2 /*return*/];
                }
                dsid = ret.rows[0].ds_id;
                _a.label = 2;
            case 2: return [4 /*yield*/, (0, db_1.queryDB)("DELETE FROM ds_metadata WHERE ds_id=$1;", [dsid])];
            case 3:
                ret = _a.sent();
                return [4 /*yield*/, (0, db_1.queryDB)("DELETE FROM ds_frontend WHERE ds_id=$1;", [dsid])];
            case 4:
                ret = _a.sent();
                res.status(204);
                res.send("Deleted.");
                return [2 /*return*/];
        }
    });
}); });
