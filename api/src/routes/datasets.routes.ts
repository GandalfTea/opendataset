import { queryDB } from "../db";
import {ds_exists} from "../utils";
import log from "../logging";
const path = require("path");
const fs = require('fs');

require("dotenv").config();
const express = require("express");
const router = express.Router();


// TODO: Cache recent downloads
router.get("/:dsid", async (req, res) => {

	if(process.env.DEBUG) const _start = process.hrtime.bigint();

	if(await ds_exists(req.params.dsid)) {
		var rp = path.resolve(__dirname, '../../tmp/', `${req.params.dsid}-` + Date.now() + ".csv");
		let ret = await queryDB(`\COPY ${req.params.dsid} TO '${rp}' WITH DELIMITER ',' CSV HEADER;`)
	
		// TODO: \COPY doesn't work, this is an empty file
		try { await fs.promises.writeFile(rp, "demo data for a demo world") } 
		catch(e) { console.log(e) }

 		res.download(rp, async (e) => { 
			if(e) console.log(e);
			else {
				try { if(fs.existsSync(rp)) await fs.promises.unlink(rp); } 
				catch(e) { console.log(e); }
				if(process.env.DEBUG) {
					const _end = process.hrtime.bigint();
					log("GET", req.socket.remoteAddress, Number(_end - _start), 200, `Download ${req.params.dsid} as CSV.`);
				}
			}
		});
	} else {
		if(process.env.DEBUG >= 1) log("GET", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
		res.status(404);
		res.send("Dataset not found.");
	}
});


// Get random percentage from dataset
router.get("/:dsid/p/:percentage", async (req, res) => {

	if(process.env.DEBUG) const _start = process.hrtime.bigint();

	if(await ds_exists(req.params.dsid)) {
		var rp = path.resolve(__dirname, '../../tmp/', `${req.params.dsid}-` + Date.now() + ".csv");
		const req_num = req.params.percentage / 100;
		let ret = await queryDB(`SELECT num_entries FROM ds_frontend WHERE ds_id=$1;`
																			, [req.params.dsid]);
		var num_entries = 0; //ret.rows[0].num_entries; 
		num_entries = 5000; // not yet in db
		var used_idx = new Set();
		while(used_idx.size < num_entries*req_num) {
			let randidx = Math.floor(Math.random() * num_entries);
			used_idx.add(randidx);
		}

		let ret = await queryDB(`\COPY (SELECT * FROM ${req.params.dsid} WHERE ds_id in 
													  (${Array.from(used_idx)})) TO ${rp} WITH DELIMITER ',' CSV HEADER;`);
		// TODO: still dummy file
		try { await fs.promises.writeFile(rp, "") } 
		catch(e) { console.log(e) }
 		res.download(rp, async (e) => { 
			if(e) console.log(e);
			else {
				try { if(fs.existsSync(rp)) await fs.promises.unlink(rp); } 
				catch(e) { console.log(e); }
				if(process.env.DEBUG) {
					const _end = process.hrtime.bigint();
					log("GET", req.socket.remoteAddress, Number(_end - _start), 200, `Download ${req.params.percentage}% of ${req.params.dsid}.`);
				}
			}
		});

	} else {
		if(process.env.DEBUG >= 1) log("GET", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
		res.status(404);
		res.send("Dataset not found.");
	}
})


// Get a sample of first 50 entries

// TODO: Switch to int dsid
router.get("/:dsid/sample", async (req, res) => {

	if(process.env.DEBUG) const _start = process.hrtime.bigint();

	if(ds_exists(req.params.dsid)) {
		if(Number.isInteger(Number(req.params.dsid))) {
 		 	var ret = await queryDB( `select ds_name from ds_metadata where ds_id=$1;`, [req.params.dsid]);
 		 	req.params.dsid = ret.rows[0].ds_name;
		}

		let ret = await queryDB(`SELECT row_to_json(${req.params.dsid}) FROM ${req.params.dsid} LIMIT 50;`);
		res.status(200);
		res.send(ret);
			if(process.env.DEBUG) {
				const _end = process.hrtime.bigint();
				log("GET", req.socket.remoteAddress, Number(_end - _start), 200, `Sample for ${req.params.dsid}.`);
			}
	} else {
		if(process.env.DEBUG >= 1) log("GET", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
		res.status(404);
		res.send("Dataset not found.");
	}
})



// TODO: Write
router.get("/:dsid/contributions/:hash", (req, res) => {
  var ds = req.params.dsid["uuid"];
  var hash = req.params.hash;
  res.status = 302;
  res.send(`GET contribution ${hash} for dataset ${ds}.`);
});



/* GET metadata about dataset */

router.get("/:dsid/details", async (req, res) => {

	if(process.env.DEBUG >=1) const _start = process.hrtime.bigint();

  var dsid: number | string = req.params.dsid;
	var query: string = req.query.q;

	if(ds_exists(dsid)) {
		if(!Number.isInteger(Number(dsid))) {
 		 	var ret = await queryDB( `select ds_id from ds_metadata where ds_name=$1;`, [dsid]);
			if(ret.rowCount === 0) {
				if(process.env.DEBUG >= 1) log("GET", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
				res.status(404);
				res.send("Dataset not found.")
				return;
			}
 		 	dsid = ret.rows[0].ds_id;
		}
	
		if(query != null) {
			if( ['description', 'readme', 'num_contributors', 'num_entries', 'licence', 'contribution_guidelines' ].includes(query)) {
				var ret = await queryDB(`SELECT ${query} FROM ds_frontend WHERE ds_id=$1`, [dsid]);
				if(process.env.DEBUG >= 1) {
					const _end = process.hrtime.bigint();
					log("GET", req.socket.remoteAddress, Number(_end - _start), 200, `Select ${query} from ${dsid}.`);
				}
				res.status(200);
				res.send(JSON.stringify(ret.rows[0]));
				return;
			}
		}
 	 	var ret = await queryDB(`SELECT * FROM ds_frontend WHERE ds_id=$1`, [dsid]);
		if(process.env.DEBUG >= 1) {
			const _end = process.hrtime.bigint();
			log("GET", req.socket.remoteAddress, Number(_end - _start), 200, `Select * from ${dsid}.`);
		}
 	 	res.status(200);
  	res.send(JSON.stringify(ret.rows[0]));
	} else {
		if(process.env.DEBUG >= 1) log("GET", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
		res.status(404);
		res.send("Dataset not found.");
	}
});



// UPDATE FRONTEND
// NOTE: Requires session.

router.patch("/:dsid/details", async (req, res) => {

	if(process.env.DEBUG >= 1) const _start = process.hrtime.bigint();

	if(req.session.user === undefined) {
		if(process.env.DEBUG >= 1) log("PATCH", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 401, `Unauthorised.`);
		res.status(401) // Unauthorized
		res.send("Login required.")
		return;
	}

	// TODO: Check if user has edit provileges on this ds
	
	var query: string = req.query.q;
	var dsid: number | string = req.params.dsid;
	if(ds_exists(dsid)) {
		if(!Number.isInteger(Number(dsid))) {
   		var ret = await queryDB( 'SELECT ds_id FROM ds_metadata WHERE ds_name=$1;', [dsid]);
			if(ret.rowCount === 0) {
				if(process.env.DEBUG >= 1) log("PATCH", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
				res.status(404);
				res.send("Dataset not found.")
				return;
			}
   		dsid = ret.rows[0].ds_id;
		}
		if(query != null) {
			var new_data = req.body['data'];
			if( ['description', 'readme', 'num_contributors', 'num_entries', 'licence', 'contribution_guidelines'].includes(query)) {
				var ret = await queryDB(`UPDATE ds_frontend SET ${query}=$1 WHERE ds_id=$2`,
															  [new_data, dsid]);
			}
			if(process.env.DEBUG >= 1) log("PATCH", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 200, `Updated ${query} for ${dsid}.`);
			res.status(200);
			res.send("Done.")
		}
	} else {
		if(process.env.DEBUG >= 1) log("PATCH", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
		res.status(404);
		res.send("Dataset not found.");
	}
});

// DELETE
// NOTE: Requires session.

router.delete("/:dsid", async (req, res) => {

	if(process.env.DEBUG >= 1) const _start = process.hrtime.bigint();

	/*
	if(req.session.user === undefined) {
		if(process.env.DEBUG >= 1) log("DELETE", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 401, `Unauthorised.`);
		res.status(401) // Unauthorized
		res.send("Login required.")
		return;
	}
	*/

	// TODO: Verify user has privilages

  var dsid: number | string = req.params.dsid;
	if(ds_exists(dsid)) {
		if(!Number.isInteger(Number(dsid))) {
   		var ret = await queryDB( 'SELECT ds_id FROM ds_metadata WHERE ds_name=$1;', [dsid]);
			if(ret.rowCount === 0) {
				if(process.env.DEBUG >= 1) log("DELETE", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
				res.status(404);
				res.send("Dataset not found.")
				return;
			}
   		dsid = ret.rows[0].ds_id;
		}
  	var ret = await queryDB(`DELETE FROM ds_metadata WHERE ds_id=$1;`, [dsid]);
  	var ret = await queryDB(`DELETE FROM ds_frontend WHERE ds_id=$1;`, [dsid]);

		// TODO: Verify delete by rowCount 1
		
		if(process.env.DEBUG >= 1) log("DELETE", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 204, `Dataset ${dsid} deleted.`);
  	res.status(204);
  	res.send("Deleted.");
	} else {
		if(process.env.DEBUG >= 1) log("DELETE", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 404, `Dataset ${req.params.dsid} not found.`);
		res.status(404);
		res.send("Dataset not found.");
	}
});

export { router };
