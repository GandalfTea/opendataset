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
exports.csv_mig_errors = exports.migrate_csv_to_db_new_table = exports.generate_schema = exports.create_ds_frontend = exports.create_ds_metadata = exports.queryDB = void 0;
var Client = require("pg").Client;
var path = require("path");
require("dotenv").config();
var utils_1 = require("./utils");
var client = new Client({
    user: process.env.PGUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: process.env.PGPORT
});
client.connect();
var queryDB = function (query, params) { return __awaiter(void 0, void 0, void 0, function () {
    var res, error_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                _a.trys.push([0, 2, , 3]);
                return [4 /*yield*/, client.query(query, params)];
            case 1:
                res = _a.sent();
                return [2 /*return*/, res];
            case 2:
                error_1 = _a.sent();
                return [2 /*return*/, error_1];
            case 3: return [2 /*return*/];
        }
    });
}); };
exports.queryDB = queryDB;
// Add table metadata to ds_metadata
function create_ds_metadata(ds_name, ds_cont, ds_owner) {
    return __awaiter(this, void 0, void 0, function () {
        var ret;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    if (!(0, utils_1.validate)(ds_name, utils_1.dtype.DS_NAME) || !(0, utils_1.validate)(ds_cont, utils_1.dtype.INT) || !(0, utils_1.validate)(ds_owner, utils_1.dtype.INT)) {
                        throw Error("Input values could not be validated.");
                    }
                    return [4 /*yield*/, queryDB("INSERT INTO ds_metadata (ds_name, contribution, owner) VALUES ( $1, $2, $3);", [ds_name, ds_cont.toString(), ds_owner.toString()])];
                case 1:
                    ret = _a.sent();
                    return [2 /*return*/];
            }
        });
    });
}
exports.create_ds_metadata = create_ds_metadata;
function create_ds_frontend(ds_name, ds_description, ds_num_cont, ds_num_entries, ds_licence, ds_contguide, ds_readme) {
    if (ds_description === void 0) { ds_description = ""; }
    if (ds_num_cont === void 0) { ds_num_cont = 0; }
    if (ds_num_entries === void 0) { ds_num_entries = 0; }
    if (ds_licence === void 0) { ds_licence = 0; }
    if (ds_contguide === void 0) { ds_contguide = ""; }
    if (ds_readme === void 0) { ds_readme = ""; }
    return __awaiter(this, void 0, void 0, function () {
        var ret, dsid, ret;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, queryDB("SELECT ds_id FROM ds_metadata WHERE ds_name='".concat(ds_name, "';"))];
                case 1:
                    ret = _a.sent();
                    dsid = ret["rows"][0]["ds_id"];
                    return [4 /*yield*/, queryDB("INSERT INTO ds_frontend (num_contributors, description, num_entries, licence, ds_id, contribution_guidelines, readme) VALUES($1, $2, $3, $4, $5, $6, $7);", [ds_num_cont, ds_description, ds_num_entries, ds_licence, dsid, ds_contguide, ds_readme])];
                case 2:
                    ret = _a.sent();
                    return [2 /*return*/];
            }
        });
    });
}
exports.create_ds_frontend = create_ds_frontend;
// Parse recieved .cvs files and upload them to the database
var spawn = require("child_process").spawn;
var execSync = require("child_process").execSync;
/*
    The current schema automation takes the first row as the names of the columns
    The responsability for this will fall on the user. Future contributions after
    the dataset was created will not have this restriction

    In : .csv filename
  Inside : hardcoded the location of the cache file and py script
  Out : bstring of schema as generated by pandas  */
function generate_schema(path, name) {
    return __awaiter(this, void 0, void 0, function () {
        var python_process;
        return __generator(this, function (_a) {
            try {
                python_process = spawn("python", [
                    "./ts/generate_schema_from_pandas.py",
                    path,
                    name,
                ]);
            }
            catch (e) {
                throw new Error(e);
            }
            return [2 /*return*/, new Promise(function (resolve, reject) {
                    python_process.stderr.on("data", function (data) {
                        process.stdout.write(data.toString());
                    });
                    python_process.on("close", function (code) {
                        console.log("Python child process finished : " + code);
                    });
                    python_process.stdout.on("data", function (data) {
                        resolve(data);
                    });
                })];
        });
    });
}
exports.generate_schema = generate_schema;
var csv_mig_errors;
(function (csv_mig_errors) {
    csv_mig_errors[csv_mig_errors["SUCCESSFUL_MIGRATION"] = 0] = "SUCCESSFUL_MIGRATION";
    csv_mig_errors[csv_mig_errors["ERROR_GENERATING_SCHEMA"] = 1] = "ERROR_GENERATING_SCHEMA";
    csv_mig_errors[csv_mig_errors["ERROR_GENERATING_DB_COMMANDS"] = 2] = "ERROR_GENERATING_DB_COMMANDS";
    csv_mig_errors[csv_mig_errors["ERROR_ILLEGAL_COLUMN_NAMES"] = 3] = "ERROR_ILLEGAL_COLUMN_NAMES";
    csv_mig_errors[csv_mig_errors["FAILURE_TO_GENERATE_TABLE"] = 4] = "FAILURE_TO_GENERATE_TABLE";
    csv_mig_errors[csv_mig_errors["FAILURE_TO_MIGRATE_CSV_INTO_TABLE"] = 5] = "FAILURE_TO_MIGRATE_CSV_INTO_TABLE";
})(csv_mig_errors || (csv_mig_errors = {}));
exports.csv_mig_errors = csv_mig_errors;
function migrate_csv_to_db_new_table(relpath, table_name, DEBUG) {
    if (DEBUG === void 0) { DEBUG = false; }
    return __awaiter(this, void 0, void 0, function () {
        var py_schema, e_1, name, split_schema, fields, i, cmd_schema, i, ret;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    _a.trys.push([0, 2, , 3]);
                    return [4 /*yield*/, generate_schema(relpath, table_name)];
                case 1:
                    py_schema = _a.sent();
                    return [3 /*break*/, 3];
                case 2:
                    e_1 = _a.sent();
                    return [2 /*return*/, csv_mig_errors.ERROR_GENERATING_SCHEMA];
                case 3:
                    name = relpath.split("-")[0];
                    relpath = "./cache/" + relpath;
                    try {
                        split_schema = py_schema
                            .toString()
                            .split("(")[1]
                            .split(")")[0]
                            .split(",");
                        fields = [];
                        for (i = 0; i < split_schema.length; i++) {
                            if (/^[a-zA-Z_][a-zA-Z0-9#$@]+/.test(split_schema[i].split('"')[1])) {
                                fields.push(split_schema[i].split('"')[1]);
                            }
                            else {
                                return [2 /*return*/, csv_mig_errors.ERROR_ILLEGAL_COLUMN_NAMES];
                            }
                        }
                        cmd_schema = "".concat(name, "(");
                        for (i = 0; i < fields.length; i++) {
                            cmd_schema += i == fields.length - 1 ? fields[i] : fields[i] + ", ";
                        }
                        cmd_schema += ")";
                    }
                    catch (e) {
                        return [2 /*return*/, csv_mig_errors.ERROR_GENERATING_DB_COMMANDS];
                    }
                    return [4 /*yield*/, queryDB(py_schema.toString())];
                case 4:
                    ret = _a.sent();
                    if (false /* check if ret is good*/)
                        return [2 /*return*/, csv_mig_errors.FAILURE_TO_GENERATE_TABLE];
                    return [4 /*yield*/, queryDB("COPY ".concat(cmd_schema, " FROM '").concat(path.resolve(relpath), "' DELIMITER ',' CSV HEADER;"))];
                case 5:
                    ret = _a.sent();
                    if (false /* check if ret is good*/)
                        return [2 /*return*/, csv_mig_errors.FAILURE_TO_MIGRATE_CSV_INTO_TABLE];
                    if (DEBUG) {
                        console.log("COPY ".concat(cmd_schema, " FROM '").concat(path.resolve(relpath), "' WITH  (FORMAT csv)\n\n"));
                        console.log(ret);
                    }
                    return [2 /*return*/, csv_mig_errors.SUCCESSFUL_MIGRATION];
            }
        });
    });
}
exports.migrate_csv_to_db_new_table = migrate_csv_to_db_new_table;
