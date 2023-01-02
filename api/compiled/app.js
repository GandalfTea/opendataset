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
var uuid_1 = require("uuid");
var assert = require('assert');
var express = require('express');
var app = express();
var PORT = 3000;
var DEBUG = true;
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
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
app.get('/', function (req, res) {
    res.send('Hello');
});
// GET
app.get('/users', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var rq;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0: return [4 /*yield*/, queryDB('SELECT * FROM users;')];
            case 1:
                rq = _a.sent();
                res.send(JSON.stringify(rq['rows']));
                return [2 /*return*/];
        }
    });
}); });
app.get('/users/:username', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var username, get;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                username = req.params.username;
                return [4 /*yield*/, queryDB("SELECT * FROM users WHERE username='".concat(username, "';"))];
            case 1:
                get = _a.sent();
                res.send("User ".concat(JSON.stringify(get['rows'])));
                return [2 /*return*/];
        }
    });
}); });
app.get('/datasets/:dsid', function (req, res) {
    var dsid = req.params.dsid;
    res.send("GET Dataset with UUID ".concat(dsid));
});
app.get('/datasets/:dsid/contributions/:hash', function (req, res) {
    var ds = req.params.dsid['uuid'];
    var hash = req.params.hash;
    res.send("GET contribution ".concat(hash, " for dataset ").concat(ds, "."));
});
// CREATE
app.post('/create/dataset', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var name, owner, owner, schema, cont, cont, cont;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                console.log("POST request");
                name = req.body['name'];
                return [4 /*yield*/, queryDB("SELECT * FROM users WHERE username='".concat(req.body['owner'], "';"))];
            case 1:
                owner = _a.sent();
                owner = owner['rows'][0]['uuid'];
                schema = req.body['schema'];
                switch (req.body['contributions']) {
                    case 'all':
                        cont = 0;
                        break;
                    case 'res':
                        cont = 1;
                        break;
                    case 'me':
                        cont = 2;
                        break;
                }
                ;
                if (DEBUG)
                    console.log("\nCREATE dataset\n\tName: ".concat(name, "\n\tOwner: ").concat(owner, "\n\tContributions: ").concat(cont, "\n\tSchema: ").concat(schema));
                res.send("Recieved data : ".concat(JSON.stringify(req.body)));
                return [2 /*return*/];
        }
    });
}); });
app.post('/create/user', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
    var username, email, uuid, now, cakeday, rq;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                username = req.body['username'];
                assert(username.length < 50 && username.length > 1);
                email = req.body['email'];
                assert(email.length < 100 && email.length > 10);
                uuid = (0, uuid_1.v4)();
                now = new Date();
                cakeday = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate();
                console.log("\n Username: ".concat(username, "\n Email: ").concat(email, "\n UUID: ").concat(uuid, "\n Cakeday: ").concat(cakeday));
                return [4 /*yield*/, queryDB("INSERT INTO users (uuid, username, cakeday, email) \n\t\t\t\t\t\t\t\t\t\t\t\t\t  VALUES('".concat(uuid, "', '").concat(username, "', '").concat(cakeday, "', '").concat(email, "');"))];
            case 1:
                rq = _a.sent();
                res.send(JSON.stringify(rq));
                return [2 /*return*/];
        }
    });
}); });
app.listen(PORT, function () {
    console.log("Example app listening on port ".concat(PORT));
});
