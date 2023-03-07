import { queryDB } from "../db";
import {user_exists} from "../utils";

const express = require("express");
const router = express.Router();

router.get("/:user", async (req: any, res: any) => {
  var username: string = req.params.user;
  var get: any = await queryDB(
    `SELECT * FROM users WHERE username=$1;`,
		[username]
  );
  res.status = 302;
  res.send(JSON.stringify(get["rows"]));
});

// DELETE
router.delete("/:user", async (req, res) => {
  var username: string = req.params.user;

	if(process.env.DEBUG >= 1) {
		process.stdout.write(`\nDELETE user    : ${req.socket.remoteAddress} : `)
		const _start = process.hrtime.bigint()
	}

	if(user_exists(username)) {
  	var query: any = await queryDB(
   		`DELETE FROM users WHERE username=$1;`,
			[username]
  	);
		if(process.env.DEBUG >=1) {
			const _end = process.hrtime.bigint();
			process.stdout.write(`SUCCESS, user ${username} deleted. \t ${ (Number(_end - _start)*1e-6).toFixed(2) }ms`)
		}
  	res.status(200);
  	res.send("Deleted");
	} else {
		if(process.env.DEBUG >= 1) {
			const _end = process.hrtime.bigint();
			process.stdout.write(`ERROR, user not found \t ${ (Number(_end - _start)*1e-6).toFixed(2) }ms`)
		}
		res.status(404)
		res.send("User not found.")
	}
  /* TODO
		[ ] ? Require some confirmation beforehand (to prevent accidental deletion) */
});

export { router };
