
import { dtype, validate, ds_exists, user_exists} from '../utils'
import log from "../logging";
const express = require("express");
const router = express.Router();
const assert = require("assert");

require("dotenv").config();

const multer = require("multer");
var temp = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./tmp");
  },
  filename: (req, file, cb) => {
    const dsname = file.originalname.split(".")[0];
    cb(null, dsname + "-" + Date.now() + ".csv");
  },
});
var upload = multer({ storage: temp });

import {
  queryDB,
  create_ds_metadata,
  create_ds_frontend,
  migrate_csv_to_db_new_table,
  csv_mig_errors,
} from "../db";


router.post("/dataset", upload.single("init"), async (req, res, next) => {

	if(process.env.DEBUG >= 1) const _start = process.hrtime.bigint();

	// Required info
	try {
		assert(req.body.owner !== null, "Owner Required.");
		assert(req.body.name !== null, "Name Required.");
	} catch(e) {
		assert(e instanceof assert.AssertionError);
		if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 400, `Missing required information.`);
		res.status(400);
		res.send("Missing required information.");
		return;
	}

	// already exists ?
	if( await ds_exists(req.body.name)) {
		if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 409, `Dataset "${req.body.name}" already exists.`);
		res.status(409); // Conflict	
    res.send(`Name Conflict.`);
    return;
	}

	if( await user_exists(req.body.owner)) {
		if(!Number.isInteger(Number(req.body.owner))) {
  		let owner_entry: string = await queryDB(`SELECT * FROM users WHERE username=$1`, [req.body.owner]);
    	const owner: number = owner_entry.rows[0].id;
		} else {
			const owner: number = req.body.owner
		}

    var cont: number = parseInt(req.body.contributions);
		if(![0, 1, 2].includes(cont)) cont=0; // Invalid contribution option
		const contguide = (req.body.contribution_guidelines == null) ? "" : req.body.contribution_guidelines;
		const description = (req.body.description == null) ? "" : req.body.description;
		const licence = (req.body.licence == null) ? 5 : parseInt(req.body.licence);
		const readme = (req.body.readme == null) ? "" : req.body.readme;

    const file: any = req.file;
    const FILE_UPLOAD: boolean = !file ? false : true;

    // metadata tables 
    await create_ds_metadata(req.body.name, cont, 0);
    await create_ds_frontend(req.body.name, description, 0, 0, licence, contguide, readme);

		// CSV File Upload 
    if (FILE_UPLOAD) {
      const ret = await migrate_csv_to_db_new_table(
        file.filename,
        req.body.name
      );
      switch (ret) {
        case csv_mig_errors.SUCCESSFUL_MIGRATION:
          if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 201, `Successful migration.`);
          res.status(201); // Created
          res.send(`Recieved data : ${JSON.stringify(req.body)}`);
          break;

        case csv_mig_errors.ERROR_GENERATING_SCHEMA:
        case csv_mig_errors.ERROR_GENERATING_DB_COMMANDS:
					if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 421, `Schema or Command generation failure.`);
          res.status(421); // Unprocessable Entity
          res.send(`Error parsing input on out end. Sorry`);
          break;

        case csv_mig_errors.ERROR_ILLEGAL_COLUMN_NAMES:
					if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 400, `Illegal Column Names`);
          res.status(400); // Bad request
          res.send(`Your file contains illegal column names. Please make sure to
										have your first row be in accordance with SQL naming conventions.`);
          break;

        case csv_mig_errors.FAILURE_TO_GENERATE_TABLE:
        case csv_mig_errors.FAILURE_TO_MIGRATE_CSV_INTO_TABLE:
					if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 500, `Failure to generate table and migration data.`);
          res.status(500); // Internal server error
          res.send(`Internal Server Error. Sorry.`);
          break;
        // TODO: ADD default
			}
    } else {
      if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 201, `Dataset ${req.body.name} created.`);
      res.status(201); // Created
      res.send(`Created`);
    }
  } else {
    if(process.env.DEBUG >= 1) process.stdout.write(`ERROR, user ${req.body.owner} not found. \t ${ (Number(process.hrtime.bigint() - _start)*1e-6).toFixed(2) }ms`);
    res.status(404);
    res.send(`User not found: ${req.body.owner}`);
    return;
	}
});



router.post("/user", async (req, res) => {

	if(process.env.DEBUG >=1) const _start = process.hrtime.bigint();

	// TODO: Shit code 
	if(!validate(req.body.username, dtype.USERNAME) || !validate(req.body.email, dtype.EMAIL)) {
		if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 422, `Incorrect information.`);
		res.status(422)
		res.send("Incorrect information")
		return;
	}

  var now = new Date();
  const cakeday: any = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();

  const rq = await queryDB(`INSERT INTO users (username, cakeday, email, password) 
														VALUES($1, $2, $3, crypt($4, gen_salt('bf')))`,
					                  [req.body['username'], cakeday, req.body['email'], req.body['password']]);
	if(process.env.DEBUG >= 1) log("POST", req.socket.remoteAddress, Number(process.hrtime.bigint() - _start), 201, `User ${req.body.username} created.`);
  res.status(201);
  res.send(JSON.stringify(rq));

  /* TODO
	 [ ] Link to a UserMetadata table for notifications and msg
	 [ ] Verify email
	 [ ] ? Karma / Rep points */
});

export { router };
