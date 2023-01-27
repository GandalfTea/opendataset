import { queryDB } from "../db";

const express = require("express");
const router = express.Router();

router.get("/:user", async (req: any, res: any) => {
  var username: string = req.params.user;
  var get: any = await queryDB(
    `SELECT * FROM users WHERE username=$1;`,
		[username]
  );
  res.status = 302;
  res.send(`User ${JSON.stringify(get["rows"])}`);
});

// DELETE
router.delete("/:user", async (req, res) => {
  var username: string = req.params.user;
	console.log(username)
  var query: any = await queryDB(
    `DELETE FROM users WHERE username=$1;`,
		[username]
  );
  res.status = 200;
  res.send(query);

  /* TODO
		[ ] ? Require some confirmation beforehand (to prevent accidental deletion) */
});

export { router };
