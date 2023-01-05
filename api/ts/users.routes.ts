import { queryDB } from "./db";

const express = require("express");
const router = express.Router();

// TODO: Prevent injection attacks (current is vulnerable)
router.get("/", async (req, res) => {
  var rq = await queryDB("SELECT * FROM users;");
  res.status = 302;
  res.send(JSON.stringify(rq["rows"]));
});

router.get("/:username", async (req: any, res: any) => {
  var username: string = req.params.username;
  var get: any = await queryDB(
    `SELECT * FROM users WHERE username='${username}';`
  );
  res.status = 302;
  res.send(`User ${JSON.stringify(get["rows"])}`);
});

// DELETE
router.delete("/:user", async (req, res) => {
  var username: string = req.params.user;
  var query: any = await queryDB(
    `DELETE FROM users WHERE username='${username}';`
  )
  res.status = 200;
  res.send(query);

  /* TODO
		[ ] ? Require some confirmation beforehand (to prevent accidental deletion) */
});

export { router };
