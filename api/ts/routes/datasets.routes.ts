import { queryDB } from "../db";

const express = require("express");
const router = express.Router();

// GET
router.get("/:dsid", (req, res) => {
  var dsid: number | string = req.params.dsid;
  res.status = 302;
  res.send(`GET Dataset with UUID ${dsid}`);
});

router.get("/:dsid/contributions/:hash", (req, res) => {
  var ds = req.params.dsid["uuid"];
  var hash = req.params.hash;
  res.status = 302;
  res.send(`GET contribution ${hash} for dataset ${ds}.`);
});

router.get("/:dsid/details", async (req, res) => {
  var dsid: number | string = req.params.dsid;
  var ret = await queryDB(
    `SELECT ds_id FROM ds_metadata WHERE ds_name=$1;`,
		[dsid]
  );
  dsid = ret["rows"][0]["ds_id"];
  var ret = await queryDB(`SELECT * FROM ds_frontend WHERE ds_id=$1`, [dsid]);
  console.log(ret);
  res.status(200);
  res.set("Access-Control-Allow-Origin", "*");
  res.send(JSON.stringify(ret));
});

// UPDATE FRONTEND

router.patch("/:dsid/frontend/description", async (req, res) => {
  console.log("HERE");
  var dsid: number | string = req.params.dsid;
  if (dsid instanceof String || typeof dsid === "string") {
    var ret = await queryDB(
      `SELECT ds_id FROM ds_metadata WHERE ds_name=$1;`,
			[dsid]
    );
    dsid = ret["rows"][0]["ds_id"];
  }
  var new_des = req.body["description"];
  console.log(Object.keys(req.body));
  var ret = await queryDB(
    `UPDATE ds_frontend SET description=$1 WHERE ds_id=$2;`,
		[new_des, dsid]
  );
  console.log(ret);
  res.status(200);
  res.send("Hello");
});

// EDIT

// DELETE
router.delete("/:dsid", async (req, res) => {
  var dsid: number | string = req.params.dsid;
  if (dsid instanceof String || typeof dsid === "string") {
    var dsname = dsid;
    var ret = await queryDB(
      `SELECT ds_id FROM ds_metadata WHERE ds_name=$1;`,
			[dsid]
    );
    dsid = ret["rows"][0]["ds_id"];
  } else {
    var ret = await queryDB(
      `SELECT ds_name FROM ds_metadata WHERE ds_id=$1;`,
			[dsid]
    );
    //var dsname = ret['rows'][0]['ds_name'];
  }
  //var ret = await queryDB(`DROP TABLE $1;`, [dsname]);
  var ret = await queryDB(`DELETE FROM ds_metadata WHERE ds_id=$1;`, [dsid]);
  var ret = await queryDB(`DELETE FROM ds_frontend WHERE ds_id=$1;`, [dsid]);
  console.log("\n\n\n", ret);
  res.status(204);
  res.send("Hello");
});

export { router };
