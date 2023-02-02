import { dtype, validate} from '../utils'
const express = require("express");
const router = express.Router();

const DEBUG: boolean = false;
var assert = require("assert");

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
  let owner_entry: string = await queryDB(
    `SELECT * FROM users WHERE username=$1;`,
		[req.body["owner"]]
  );

  // Check if owner account exists
  if (owner_entry["rowCount"] <= 0) {
    process.stdout.write(`REJECTED, user ${req.body["owner"]} not found.`);
    res.status(404);
    res.send(`User not found: ${req.body["owner"]}`);
    return;
  } else {
    // Check if dataset name already exists
    const name: string = req.body["name"];
    let ret = await queryDB(
      `SELECT EXISTS ( SELECT FROM information_schema.tables WHERE table_name=$1);`,
			[name]
    );
    if (ret["rows"][0]["exists"] == true) {
      process.stdout.write(`REJECTED, dataset ${name} already exists.`);
      res.status(409); // Conflict
      res.send(`A dataset with the name ${name} already exists.`);
      return;
    }

    const owner: string = owner_entry["rows"][0]["id"];
    const cont: number = parseInt(req.body["contributions"]); // TODO: Maybe test if [0-2]
    const schema: string = req.body["schema"]; // TODO: REDUNDANT

    const file: any = req.file;
    const FILE_UPLOAD: boolean = !file ? false : true;

    // ADD TABLE METADATA TO ds_metadata in DB
    // TODO: Get owner id
    await create_ds_metadata(req.body["name"], cont, 0);
    await create_ds_frontend(req.body["name"]);

    if (FILE_UPLOAD) {
      const ret = await migrate_csv_to_db_new_table(
        file.filename,
        req.body["name"]
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

      /* TODO: Once the file is in local storage
				[?] Migrate the data
				[ ] Validate input    */
    } else {
      process.stdout.write(`RESOLVED, dataset '${name}' created.`);
      if (DEBUG)
        console.log(`\n${name}\n\towner: ${owner}\n
														 \tcontributions: ${cont}\n\tschema: ${schema}`);
      res.status(201); // Created
      res.send(`Recieved data : ${JSON.stringify(req.body)}`);
    }
  }

  /* TODO
	 [X] Search DB database to make sure name is unique
	 [x] Search owner in User DB.
	 [X] protect against injection attacks
	 [X] parse schema into database creation command
	 [X] check data format and schema + safety check?
	 [X] error catching and sending
	 [X] respond with success */
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
