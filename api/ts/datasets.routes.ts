import { queryDB } from "./db";

const express = require("express");
const router = express.Router();

// GET
router.get("/:dsid", (req, res) => {
  var dsid: number = req.params.dsid;
  res.status = 302;
  res.send(`GET Dataset with UUID ${dsid}`);
});

router.get("/:dsid/contributions/:hash", (req, res) => {
  var ds = req.params.dsid["uuid"];
  var hash = req.params.hash;
  res.status = 302;
  res.send(`GET contribution ${hash} for dataset ${ds}.`);
});

// EDIT
// DELETE

export { router };
