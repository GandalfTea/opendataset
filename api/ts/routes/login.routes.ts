import { queryDB } from "../db";

const express = require("express");
const router = express.Router();

router.post("/", async (req, res) => {
  // Recieve username and password;
  var ret = await queryDB(
    `SELECT * FROM users WHERE username=$1 AND password=crypt($2, password);`,
		[req.body['username'], req.body['password']]
  );
  if (parseInt(ret["rowCount"]) > 0) {
    console.log(ret);
    res.status(200);
    res.send("Successful Login");
  } else {
    console.log(ret);
    res.status(400);
    res.send("Wrong Password");
  }
});

export { router };
