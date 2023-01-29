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
var utils_1 = require("../utils");
var express = require("express");
var router = express.Router();
exports.router = router;
var DEBUG = false;
var assert = require("assert");
var multer = require("multer");
var cache = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "./cache");
    },
    filename: function (req, file, cb) {
        var dsname = file.originalname.split(".")[0];
        cb(null, dsname + "-" + Date.now() + ".csv");
    }
});
var upload = multer({ storage: cache });
var db_1 = require("../db");
router.post("/dataset", upload.single("init"), function (req, res, next) { return __awaiter(void 0, void 0, void 0, function () {
    var owner_entry, name_1, ret, owner, cont, schema, file, FILE_UPLOAD, ret_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                process.stdout.write("\tCREATE ds : ".concat(req.socket.remoteAddress, " : "));
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT * FROM users WHERE username=$1;", [req.body["owner"]])];
            case 1:
                owner_entry = _a.sent();
                if (!(owner_entry["rowCount"] <= 0)) return [3 /*break*/, 2];
                process.stdout.write("REJECTED, user ".concat(req.body["owner"], " not found."));
                res.status(404);
                res.send("User not found: ".concat(req.body["owner"]));
                return [2 /*return*/];
            case 2:
                name_1 = req.body["name"];
                return [4 /*yield*/, (0, db_1.queryDB)("SELECT EXISTS ( SELECT FROM information_schema.tables WHERE table_name=$1);", [name_1])];
            case 3:
                ret = _a.sent();
                if (ret["rows"][0]["exists"] == true) {
                    process.stdout.write("REJECTED, dataset ".concat(name_1, " already exists."));
                    res.status(409); // Conflict
                    res.send("A dataset with the name ".concat(name_1, " already exists."));
                    return [2 /*return*/];
                }
                owner = owner_entry["rows"][0]["id"];
                cont = parseInt(req.body["contributions"]);
                schema = req.body["schema"];
                file = req.file;
                FILE_UPLOAD = !file ? false : true;
                // ADD TABLE METADATA TO ds_metadata in DB
                // TODO: Get owner id
                return [4 /*yield*/, (0, db_1.create_ds_metadata)(req.body["name"], cont, 0)];
            case 4:
                // ADD TABLE METADATA TO ds_metadata in DB
                // TODO: Get owner id
                _a.sent();
                return [4 /*yield*/, (0, db_1.create_ds_frontend)(req.body["name"])];
            case 5:
                _a.sent();
                if (!FILE_UPLOAD) return [3 /*break*/, 7];
                return [4 /*yield*/, (0, db_1.migrate_csv_to_db_new_table)(file.filename, req.body["name"])];
            case 6:
                ret_1 = _a.sent();
                switch (ret_1) {
                    case db_1.csv_mig_errors.SUCCESSFUL_MIGRATION:
                        process.stdout.write(" Successful data migration, dataset '".concat(name_1, "' created."));
                        if (DEBUG)
                            console.log("\n".concat(name_1, "\n\towner: ").concat(owner, "\n\n\t\t\t\t\t\t\t\t\t\t\t\t \tcontributions: ").concat(cont, "\n\tschema: ").concat(schema, "\n\tfile: ").concat(file.filename));
                        res.status(201); // Created
                        res.send("Recieved data : ".concat(JSON.stringify(req.body)));
                        break;
                    case db_1.csv_mig_errors.ERROR_GENERATING_SCHEMA:
                    case db_1.csv_mig_errors.ERROR_GENERATING_DB_COMMANDS:
                        process.stdout.write("ERROR, Schema or Commands generation failure");
                        res.status(421); // Unprocessable Entity
                        res.send("Error parsing input on out end. Sorry");
                        break;
                    case db_1.csv_mig_errors.ERROR_ILLEGAL_COLUMN_NAMES:
                        process.stdout.write("ERROR, Illegal column names");
                        res.status(400); // Bad request
                        res.send("Your file contains illegal column names. Please make sure to\n\t\t\t\t\t\t\t\t\t\thave your first row be in accordance with SQL naming conventions.");
                        break;
                    case db_1.csv_mig_errors.FAILURE_TO_GENERATE_TABLE:
                    case db_1.csv_mig_errors.FAILURE_TO_MIGRATE_CSV_INTO_TABLE:
                        process.stdout.write("ERROR, Database error");
                        res.status(500); // Internal server error
                        res.send("Internal Server Error. Sorry.");
                        break;
                    // TODO: ADD default
                }
                return [3 /*break*/, 8];
            case 7:
                process.stdout.write("RESOLVED, dataset '".concat(name_1, "' created."));
                if (DEBUG)
                    console.log("\n".concat(name_1, "\n\towner: ").concat(owner, "\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t \tcontributions: ").concat(cont, "\n\tschema: ").concat(schema));
                res.status(201); // Created
                res.send("Recieved data : ".concat(JSON.stringify(req.body)));
                _a.label = 8;
            case 8: return [2 /*return*/];
        }
    });
}); });
router.post("/user", function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var now, cakeday, rq;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                console.log("CREATE user REQUEST from:  ".concat(req.socket.remoteAddress));
                _a.label = 1;
            case 1:
                _a.trys.push([1, , 3, 4]);
                assert(req.body['username'].length < 50 && req.body['username'].length > 1);
                assert((0, utils_1.validate)(req.body['username'], utils_1.dtype.USERNAME));
                assert((0, utils_1.validate)(req.body['email'], utils_1.dtype.EMAIL));
                try {
                }
                catch (err) {
                    assert(err instanceof assert.AssertionError);
                    res.status(422);
                    res.send("Incorrect information");
                }
                now = new Date();
                cakeday = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
                return [4 /*yield*/, (0, db_1.queryDB)("INSERT INTO users (username, cakeday, email, password) \n\t\t\t\t\t\t\t\t\t\t\t\t\t\tVALUES($1, $2, $3, crypt($4, gen_salt('bf')))", [req.body['username'], cakeday, req.body['email'], req.body['password']])];
            case 2:
                rq = _a.sent();
                //console.log(rq);
                res.status(201);
                res.send(JSON.stringify(rq));
                return [3 /*break*/, 4];
            case 3: return [7 /*endfinally*/];
            case 4: return [2 /*return*/];
        }
    });
}); });
