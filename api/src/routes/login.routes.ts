import { queryDB } from "../db";
import { user_exists } from "../utils";

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
			if(process.env.DEBUG >= 1) {
				const _end = process.hrtime.bigint();
				process.stdout.write(`\nLOGIN  User ${req.body.username} ${req.socket.remoteAddress} :    SUCCESS`.padEnd(90))
				process.stdout.write(`${(Number(_end - _start)*1e-6).toFixed(2)}ms`)
				if(process.env.DEBUG >= 2) process.stdout.write(`\n ${req.session}`)
			}
    	res.status(200);
    	res.send("Successful Login.");
  	} else {
    	res.status(400);
    	res.send("Wrong Password");
  	}
	} else {
    res.status(404);
    res.send(`User not found: ${req.body.username}`);
    return;
	}
});

export { router };
