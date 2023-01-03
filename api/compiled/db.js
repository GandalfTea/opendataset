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
exports.migrate_csv_to_db_new_table = exports.generate_schema = exports.queryDB = void 0;
var Client = require('pg').Client;
var queryDB = function (query) { return __awaiter(void 0, void 0, void 0, function () {
    var client, res, error_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                _a.trys.push([0, 4, , 5]);
                client = new Client({
                    user: 'su',
                    host: '127.0.0.1',
                    database: 'api',
                    password: 'lafiel',
                    port: '5432'
                });
                return [4 /*yield*/, client.connect()];
            case 1:
                _a.sent();
                return [4 /*yield*/, client.query(query)];
            case 2:
                res = _a.sent();
                return [4 /*yield*/, client.end()];
            case 3:
                _a.sent();
                return [2 /*return*/, res];
            case 4:
                error_1 = _a.sent();
                return [2 /*return*/, error_1];
            case 5: return [2 /*return*/];
        }
    });
}); };
exports.queryDB = queryDB;
// Parse recieved .cvs files and upload them to the database
var spawn = require('child_process').spawn;
function generate_schema(path) {
    var python_process = spawn('python', ['./generate_schema_from_pandas.py', path]);
    python_process.stdout.on('data', function (data) {
        return data.toString();
    });
}
exports.generate_schema = generate_schema;
// generate_schema('../cache/demo-1672779676422.csv');
function migrate_csv_to_db_new_table(path, table_name) {
    return __awaiter(this, void 0, void 0, function () {
        var py_schema, create_schema, cmd_schema;
        return __generator(this, function (_a) {
            py_schema = generate_schema(path);
            create_schema = py_schema;
            cmd_schema = py_schema;
            queryDB(create_schema);
            queryDB("COPY ".concat(cmd_schema, " FROM ").concat(path, " DELIMITER ',' CSV HEADER;"));
            return [2 /*return*/];
        });
    });
}
exports.migrate_csv_to_db_new_table = migrate_csv_to_db_new_table;
