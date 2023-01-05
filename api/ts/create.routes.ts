const express = require("express");
const router = express.Router();

const DEBUG: boolean = false;
var assert = require("assert");
import { v4 as uuidv4 } from "uuid";

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

import { queryDB, migrate_csv_to_db_new_table, csv_mig_errors } from "./db";

// CREATE
router.post("/dataset", upload.single("init"), async (req, res, next) => {
  process.stdout.write(`\tCREATE ds : ${req.socket.remoteAddress} : `);
  let owner_entry: string = await queryDB(
    `SELECT * FROM users WHERE username='${req.body["owner"]}';`
  );

  // Check if owner account exists
  if (owner_entry["rowCount"] <= 0) {
    process.stdout.write(`REJECTED, user ${req.body["owner"]} not found.`);
    res.status(404);
    res.send(`User not found: ${req.body["owner"]}`);
  } else {
    // Check if dataset name already exists
    const name: string = req.body["name"];
    let ret = await queryDB(
      `SELECT EXISTS ( SELECT FROM information_schema.tables WHERE table_name='${name}');`
    );
    if (ret["rows"][0]["exists"] != "true") {
      res.status(409); // Conflict
      res.send(`A dataset with the name ${name} already exists.`);
    }

    const owner: string = owner_entry["rows"][0]["uuid"];
    const cont: number = parseInt(req.body["contributions"]); // TODO: Maybe test if [0-2]
    const schema: string = req.body["schema"]; // TODO: REDUNDANT

    const file: any = req.file;
    const FILE_UPLOAD: boolean = !file ? false : true;

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
      }

      /* TODO: Once the file is in local storage
				[x] Automatic schema generation
				[x] Create new table in DB using schema
				[?] Migrate the data
				[ ] ? Link table to a meta table of contributions
				[ ] ? Register table in metatable of datasets */
    } else {
      res.status(201); // Created
      process.stdout.write(`RESOLVED, dataset '${name}' created.`);
      if (DEBUG)
        console.log(`\n${name}\n\towner: ${owner}\n
														 \tcontributions: ${cont}\n\tschema: ${schema}`);
      res.send(`Recieved data : ${JSON.stringify(req.body)}`);
    }
  }

  /* TODO
	 [ ] Search DB database to make sure name is unique
	 [x] Search owner in User DB.
	 [ ] protect against injection attacks
	 [ ] parse schema into database creation command
	 [ ] check data format and schema + safety check?
	 [ ] error catching and sending
	 [ ] respond with success */
});

router.post("/user", async (req, res) => {
  console.log(`CREATE user REQUEST from:  ${req.socket.remoteAddress}`);

  const username: string = req.body["username"];
  assert(username.length < 50 && username.length > 1);
  const email: string = req.body["email"];
  assert(email.length < 100 && email.length > 10);
  // TODO: Actually check if email is correct lol
  const uuid: string = uuidv4();
  var now = new Date();
  const cakeday: any =
    now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
  console.log(
    `\n Username: ${username}\n Email: ${email}\n UUID: ${uuid}\n Cakeday: ${cakeday}`
  );
  const rq =
    await queryDB(`INSERT INTO users (uuid, username, cakeday, email, password) 
														VALUES('${uuid}', '${username}', '${cakeday}', '${email}', crypt('${req.body["password"]}', gen_salt('bf')));`);
  console.log(rq);
  res.status = 201;
  res.send(JSON.stringify(rq));

  /* TODO
	 [ ] Require passward
	 [ ] Check if username already exists
	 [ ] Regex check username
	 [ ] Link to a UserMetadata table for notifications and msg
	 [ ] Verify email
	 [ ] ? Hold pointer to databases created
	 [ ] ? Karma / Rep points */
});

export { router };
