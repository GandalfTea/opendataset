import { queryDB } from "../db";
import {ds_exists} from "../utils";
const path = require("path");
const fs = require('fs');

require("dotenv").config();
const express = require("express");
const router = express.Router();


// TODO: Cache recent downloads
router.get("/:dsid", async (req, res) => {
	if(process.env.DEBUG) {
		process.stdout.write(`\nGET    ${req.params.dsid} : `);
		const _start = process.hrtime.bigint();
	}

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
					process.stdout.write(`${"".padStart(20)}SUCCESS`.padEnd(74)) 
					process.stdout.write(`${(Number(_end - _start)*1e-6).toFixed(2)}ms`)
				}
			}
		});
	} else {
		process.stdout.write(`ERROR \t Dataset does not exist`);
		res.status(404);
		res.send("Dataset not found.");
	}
});


// Get random percentage from dataset
router.get("/:dsid/p/:percentage", async (req, res) => {
	if(process.env.DEBUG) {
		process.stdout.write(`\nGET    ${req.params.percentage}% ${req.params.dsid}`);
		const _start = process.hrtime.bigint();
	}

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
					process.stdout.write(`\t success \t ${ (Number(_end - _start)*1e-6).toFixed(2) }ms`)
				}
			}
		});

	} else {
		if(process.env.DEBUG) process.stdout.write("\tERROR \t dataset does not exits.");
		res.status(404);
		res.send("Dataset not found.");
	}
})


// Get a sample of first 50 entries

// TODO: Switch to int dsid
router.get("/:dsid/sample", async (req, res) => {
	if(process.env.DEBUG) {
		process.stdout.write(`\nGET    SAMPLE ${req.params.dsid}`);
		const _start = process.hrtime.bigint();
	}
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
				process.stdout.write(`${"".padStart(10)}SUCCESS`.padEnd(70)) 
				process.stdout.write(`${(Number(_end - _start)*1e-6).toFixed(2)}ms`)
			}
	} else {
		process.stdout.write(`\t ERROR \t Dataset does not exist`);
		res.status(404);
		res.send("Dataset not found.");
	}
})



router.get("/:dsid/contributions/:hash", (req, res) => {
  var ds = req.params.dsid["uuid"];
  var hash = req.params.hash;
  res.status = 302;
  res.send(`GET contribution ${hash} for dataset ${ds}.`);
});



/* GET metadata about dataset */

router.get("/:dsid/details", async (req, res) => {
  var dsid: number | string = req.params.dsid;
	var query: string = req.query.q;
	if(process.env.DEBUG >=1)
		const _start = process.hrtime.bigint();
	if(ds_exists(dsid)) {
		if(!Number.isInteger(Number(dsid))) {
 		 	var ret = await queryDB( `select ds_id from ds_metadata where ds_name=$1;`, [dsid]);
			if(ret.rowCount === 0) {
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
					process.stdout.write(`\nSELECT ${query} from ${dsid} : ${req.socket.remoteAddress} : ${"".padStart(6)}SUCCESS`.padEnd(97)) 
					process.stdout.write(`${(Number(_end - _start)*1e-6).toFixed(2)}ms`)
				}
				res.status(200);
				res.send(JSON.stringify(ret.rows[0]));
				return;
			}
		}
		if(process.env.DEBUG >= 1) {
			const _end = process.hrtime.bigint();
			process.stdout.write(`\nSELECT * from ${dsid} : ${req.socket.remoteAddress} : ${"".padStart(6)}SUCCESS`.padEnd(97)) 
			process.stdout.write(`${(Number(_end - _start)*1e-6).toFixed(2)}ms`)
		}
 	 	var ret = await queryDB(`SELECT * FROM ds_frontend WHERE ds_id=$1`, [dsid]);
 	 	res.status(200);
  	res.send(JSON.stringify(ret.rows[0]));
	} else {
		process.stdout.write(`\t ERROR \t Dataset does not exist`);
		res.status(404);
		res.send("Dataset not found.");
	}
});



// UPDATE FRONTEND
// NOTE: Requires session.

router.patch("/:dsid/details", async (req, res) => {

	if(req.session.user === undefined) {
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
			res.status(200);
			res.send("Done.")
		}
	} else {
		process.stdout.write(`\t ERROR \t Dataset does not exist`);
		res.status(404);
		res.send("Dataset not found.");
	}
});

// DELETE
// NOTE: Requires session.

router.delete("/:dsid", async (req, res) => {

	if(req.session.user === undefined) {
		res.status(401) // Unauthorized
		res.send("Login required.")
		return;
	}

	// TODO: Verify user has privilages

  var dsid: number | string = req.params.dsid;
	if(ds_exists(dsid)) {
		if(!Number.isInteger(Number(dsid))) {
   		var ret = await queryDB( 'SELECT ds_id FROM ds_metadata WHERE ds_name=$1;', [dsid]);
			if(ret.rowCount === 0) {
				res.status(404);
				res.send("Dataset not found.")
				return;
			}
   		dsid = ret.rows[0].ds_id;
		}
  	var ret = await queryDB(`DELETE FROM ds_metadata WHERE ds_id=$1;`, [dsid]);
  	var ret = await queryDB(`DELETE FROM ds_frontend WHERE ds_id=$1;`, [dsid]);

		// TODO: Verify delete by rowCount 1
		
  	res.status(204);
  	res.send("Deleted.");
	} else {
		process.stdout.write(`\t ERROR \t Dataset does not exist`);
		res.status(404);
		res.send("Dataset not found.");
	}
});

export { router };
