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

router.get('/:dsid/details', async (req, res) => {
	var dsid: number | string = req.params.dsid;
	var ret = await queryDB(`SELECT * FROM ds_frontend WHERE ds_id='${dsid}'`);
	console.log(ret);
	res.status(200)
	res.send("Hello")
})

// EDIT
// DELETE
router.delete('/:dsid', async (req, res) => {
	var dsid: number | string = req.params.dsid
	if( dsid instanceof String || typeof dsid === 'string') {
		// get  id
		var ret = await queryDB(`SELECT ds_id FROM ds_metadata WHERE ds_name='${dsid}';`)
		dsid = ret['rows'][0]['ds_id'];
	}
	// Delete DS table first!
	
	var ret = await queryDB(`DELETE FROM ds_metadata WHERE ds_id='${dsid}';`)
	var ret = await queryDB(`DELETE FROM ds_frontend WHERE ds_id='${dsid}';`)
	console.log("\n\n\n", ret)
	res.status(204)
	res.send("Hello")
})

export { router };
