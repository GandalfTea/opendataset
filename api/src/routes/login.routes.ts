import { queryDB } from "../db";
import { user_exists } from "../utils";
import log from "../logging";

const express = require("express");
const router = express.Router();

router.post("/", async (req, res) => {

	if(process.env.DEBUG >= 1) const _start = process.hrtime.bigint()

	if(user_exists(req.body.username)) {
  	var ret = await queryDB(
   		`SELECT * FROM users WHERE username=$1 AND password=crypt($2, password);`,
			[req.body.username, req.body.password]);

  	if (parseInt(ret.rowCount) > 0) {
			req.session.user = req.body.username;
			req.session.save();
			if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start),
																		 201, `Successful login for user ${req.body.username}`);
			if(process.env.DEBUG >= 2) process.stdout.write(`\n ${req.session}`)
    	res.status(200);
    	res.send("Successful Login.");
  	} else {
			if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start),
																		 400, `Incorrect credentials.`);
    	res.status(400);
    	res.send("Wrong Password");
  	}
	} else {
		if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start),
																		404, `User not found.`);
    res.status(404);
    res.send(`User not found: ${req.body.username}`);
    return;
	}
});

export { router };
