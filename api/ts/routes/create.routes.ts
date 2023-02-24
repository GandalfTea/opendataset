import { dtype, validate, ds_exists, user_exists} from '../utils'
const express = require("express");
const router = express.Router();
var assert = require("assert");

const DEBUG: boolean = false;

const multer = require("multer");
var cache = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./cache");
  },
  filename: (req, file, cb) => {
    const dsname = file.originalname.split(".")[0];
    cb(null, dsname + "-" + Date.now() + ".csv");
  },
});
var upload = multer({ storage: cache });

import {
  queryDB,
  create_ds_metadata,
  create_ds_frontend,
  migrate_csv_to_db_new_table,
  csv_mig_errors,
} from "../db";


router.post("/dataset", upload.single("init"), async (req, res, next) => {
  process.stdout.write(`\tCREATE ds : ${req.socket.remoteAddress} : `);

	// Required info
	try {
		assert(req.body.owner !== null, "");
		assert(req.body.name !== null);
	} catch(e) {
		assert(e instanceof assert.AssertionError);
		process.stdout.write("ERROR: Missing required information.");
		res.status(400);
		res.send("Missing required information.");
		return;
	}

	// already exists ?
	if(ds_exists(req.body.name)) {
		res.status(409); // Conflict	
    res.send(`A dataset with the name ${req.body.name} already exists.`);
    return;
	}

	if(user_exists(req.body.owner)) {
		if(!Number.isInteger(Number(req.body.owner))) {
  		let owner_entry: string = await queryDB(`SELECT * FROM users WHERE username=$1`, [req.body.owner]);
    	const owner: number = owner_entry.rows[0].id;
		} else {
			const owner: number = req.body.owner
		}

    var cont: number = parseInt(req.body.contributions);
		if(![0, 1, 2].includes(cont)) cont=0; // Invalid contribution option

		const contguide = (req.body.contribution_guidelines == null) ? "" : req.body.contribuition_guidelines;
		const description = (req.body.description == null) ? "" : req.body.description;
		const licence = (req.body.licence == null) ? 5 : parseInt(req.body.licence); // Default is All Rights Reserved
		const readme = (req.body.readme == null) ? "" : req.body.readme;

    const file: any = req.file;
    const FILE_UPLOAD: boolean = !file ? false : true;

    // metadata tables 
    await create_ds_metadata(req.body.name, cont, 0);
    await create_ds_frontend(req.body.name, description, 0, 0, licence, contguide, readme);

		// initial data
    if (FILE_UPLOAD) {
      const ret = await migrate_csv_to_db_new_table(
        file.filename,
        req.body.name
      );
      switch (ret) {
        case csv_mig_errors.SUCCESSFUL_MIGRATION:
          process.stdout.write(
            ` Successful data migration, dataset '${name}' created.`
          );
          if (DEBUG)
            console.log(`\n${name}\n\towner: ${owner}\n
												 \tcontributions: ${cont}\n\tschema: ${schema}\n\tfile: ${file.filename}`);
          res.status(201); // Created
          res.send(`Recieved data : ${JSON.stringify(req.body)}`);
          break;

        case csv_mig_errors.ERROR_GENERATING_SCHEMA:
        case csv_mig_errors.ERROR_GENERATING_DB_COMMANDS:
          process.stdout.write(`ERROR, Schema or Commands generation failure`);
          res.status(421); // Unprocessable Entity
          res.send(`Error parsing input on out end. Sorry`);
          break;

        case csv_mig_errors.ERROR_ILLEGAL_COLUMN_NAMES:
          process.stdout.write(`ERROR, Illegal column names`);
          res.status(400); // Bad request
          res.send(`Your file contains illegal column names. Please make sure to
										have your first row be in accordance with SQL naming conventions.`);
          break;

        case csv_mig_errors.FAILURE_TO_GENERATE_TABLE:
        case csv_mig_errors.FAILURE_TO_MIGRATE_CSV_INTO_TABLE:
          process.stdout.write(`ERROR, Database error`);
          res.status(500); // Internal server error
          res.send(`Internal Server Error. Sorry.`);
          break;
        // TODO: ADD default
			}
    } else {
      process.stdout.write(`RESOLVED, dataset '${name}' created.`);
      if (DEBUG)
        console.log(`\n${name}\n\towner: ${owner}\n
														 \tcontributions: ${cont}\n\tschema: ${schema}`);
      res.status(201); // Created
      res.send(`Recieved data : ${JSON.stringify(req.body)}`);
    }
  } else {
    process.stdout.write(`REJECTED, user ${req.body.owner} not found.`);
    res.status(404);
    res.send(`User not found: ${req.body.owner}`);
    return;
	}
});

router.post("/user", async (req, res) => {

  console.log(`CREATE user REQUEST from:  ${req.socket.remoteAddress}`);

	try {
		assert(validate(req.body['username'], dtype.USERNAME));
		assert(validate(req.body['email'], dtype.EMAIL));
	catch(err) {
		assert(err instanceof assert.AssertionError);
		res.status(422)
		res.send("Incorrect information")
	}

  var now = new Date();
  const cakeday: any = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();

  const rq =
    await queryDB(`INSERT INTO users (username, cakeday, email, password) 
														VALUES($1, $2, $3, crypt($4, gen_salt('bf')))`,
					        [req.body['username'], cakeday, req.body['email'], req.body['password']]);
  //console.log(rq);
  res.status(201);
  res.send(JSON.stringify(rq));

  /* TODO
	 [ ] Check if rq is ERROR
	 [X] Check if username already exists
	 [X] Regex check username
	 [ ] Link to a UserMetadata table for notifications and msg
	 [ ] Verify email
	 [ ] ? Karma / Rep points */
});

export { router };
