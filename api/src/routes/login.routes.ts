import { queryDB } from "../db";

const express = require("express");
const router = express.Router();

// [ ] JWT token that expire in 1h

router.post("/", async (req, res) => {
  var ret = await queryDB(
    `SELECT * FROM users WHERE username=$1 AND password=crypt($2, password);`,
		[req.body['username'], req.body['password']]
  );
  if (parseInt(ret["rowCount"]) > 0) {
		console.log(`LOGIN SUCCESSFUL for user ${req.body['username']}`);
    res.status(200);
    res.send("Successful Login");
  } else {
    console.log(ret);
    res.status(400);
    res.send("Wrong Password");
  }
});

export { router };
