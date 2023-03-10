import { queryDB } from "../db";
import {user_exists} from "../utils";
import log from "../logging";

const express = require("express");
const router = express.Router();

router.get("/:user", async (req: any, res: any) => {
	if(process.env.DEBUG >= 1) const _start = process.hrtime.bigint();
  var username: string = req.params.user;
  var get: any = await queryDB(
    `SELECT * FROM users WHERE username=$1;`,
		[username]
  );
	log("GET", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 200, `Get user ${username}.`);
  res.status = 302;
  res.send(JSON.stringify(get["rows"]));
});


// DELETE
// Note: Requires session.

router.delete("/:user", async (req, res) => {

	if(process.env.DEBUG >= 1) const _start = process.hrtime.bigint()

  var username: string = req.params.user;

	if(req.session.user === undefined || req.session.user !== username) {
		res.status(401) // Unauthorised
		res.send("Unauthorised.")
		return;
	}

	if(user_exists(username)) {
  	var query: any = await queryDB(
   		`DELETE FROM users WHERE username=$1;`,
			[username]
  	);
		if(process.env.DEBUG >=1) {
			const _end = process.hrtime.bigint();
			log("DELETE", req.socket.remoteAddress, Number(_end - _start), 200, `User ${req.body.username} deleted.`);
		}
  	res.status(200);
  	res.send("Deleted");
	} else {
		if(process.env.DEBUG >= 1) {
			const _end = process.hrtime.bigint();
			log("DELETE", req.socket.remoteAddress, Number(_end - _start), 404, `User ${req.body.username} not found.`);
		}
		res.status(404)
		res.send("User not found.")
	}
});

export { router };
