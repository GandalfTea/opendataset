const { Client } = require("pg");
const path = require("path");
require("dotenv").config();
import { dtype, validate } from './utils';

const client = new Client({
	user: process.env.PGUSER,
	host: process.env.PGHOST,
	database: process.env.PGDATABASE,
	password: process.env.PGPASSWORD,
	port: process.env.PGPORT,
});

client.connect();

const queryDB = async (query:string, params) => {
  try {
    const res: any = await client.query(query, params);
    return res;
  } catch (error) {
    return error;
  }
};

// Add table metadata to ds_metadata

async function create_ds_metadata(
  ds_name: string,
  ds_cont: number,
  ds_owner: number
) {
	if( !validate(ds_name, dtype.DS_NAME) || !validate(ds_cont, dtype.INT) || !validate(ds_owner, dtype.INT)) {
		throw Error("Input values could not be validated.")
	}
  let ret = await queryDB(
    `INSERT INTO ds_metadata (ds_name, contribution, owner) VALUES ( $1, $2, $3);`,
		[ds_name, ds_cont.toString(), ds_owner.toString()]
  );
  console.log(ret);
}

async function create_ds_frontend(
  ds_name: string,
  ds_description: string = "",
  ds_num_cont: number = 0,
  ds_num_entries: number = 0,
  ds_licence: number = 0
) {
  var ret = await queryDB(
    `SELECT ds_id FROM ds_metadata WHERE ds_name='${ds_name}';`
  );
  const dsid = ret["rows"][0]["ds_id"];
  var ret = await queryDB(
    `INSERT INTO ds_frontend (num_contributors, description, num_entries, licence, ds_id) VALUES($1, $2, $3, $4, $5);`,
		[ds_num_cont, ds_description, ds_num_entries, ds_licence, dsid]
  );
  console.log(ret);
}

// Parse recieved .cvs files and upload them to the database

const spawn = require("child_process").spawn;
const execSync = require("child_process").execSync;

/*
	The current schema automation takes the first row as the names of the columns
	The responsability for this will fall on the user. Future contributions after
	the dataset was created will not have this restriction 

	In : .csv filename
  Inside : hardcoded the location of the cache file and py script
  Out : bstring of schema as generated by pandas  */

async function generate_schema(path: string, name: string) {
  try {
    var python_process = spawn("python", [
      "./ts/generate_schema_from_pandas.py",
      path,
      name,
    ]);
  } catch (e) {
    throw new Error(e);
  }

  return new Promise((resolve, reject) => {
    python_process.stderr.on("data", (data) => {
      process.stdout.write(data.toString());
    });
    python_process.on("close", (code) => {
      console.log("Python child process finished : " + code);
    });
    python_process.stdout.on("data", (data) => {
      resolve(data);
    });
  });
}

enum csv_mig_errors {
  SUCCESSFUL_MIGRATION,
  ERROR_GENERATING_SCHEMA,
  ERROR_GENERATING_DB_COMMANDS,
  ERROR_ILLEGAL_COLUMN_NAMES,
  FAILURE_TO_GENERATE_TABLE,
  FAILURE_TO_MIGRATE_CSV_INTO_TABLE,
}

async function migrate_csv_to_db_new_table(
  relpath: string,
  table_name: string,
  DEBUG: boolean = false
) {
  try {
    var py_schema = await generate_schema(relpath, table_name);
  } catch (e) {
    return csv_mig_errors.ERROR_GENERATING_SCHEMA;
  }

  const name = relpath.split("-")[0];
  relpath = "./cache/" + relpath;

  try {
    var split_schema: string[] = py_schema
      .toString()
      .split("(")[1]
      .split(")")[0]
      .split(",");
    var fields: string[] = [];

    for (let i = 0; i < split_schema.length; i++) {
      if (/^[a-zA-Z_][a-zA-Z0-9#$@]+/.test(split_schema[i].split('"')[1])) {
        fields.push(split_schema[i].split('"')[1]);
      } else {
        return csv_mig_errors.ERROR_ILLEGAL_COLUMN_NAMES;
      }
    }
    var cmd_schema = `${name}(`;
    for (let i = 0; i < fields.length; i++) {
      cmd_schema += i == fields.length - 1 ? fields[i] : fields[i] + ", ";
    }
    cmd_schema += ")";
  } catch (e) {
    return csv_mig_errors.ERROR_GENERATING_DB_COMMANDS;
  }

  var ret: string = await queryDB(py_schema.toString());
  if (false /* check if ret is good*/)
    return csv_mig_errors.FAILURE_TO_GENERATE_TABLE;

  ret = await queryDB(
    `COPY ${cmd_schema} FROM '${path.resolve(
      relpath
    )}' DELIMITER ',' CSV HEADER;`
  );
  if (false /* check if ret is good*/)
    return csv_mig_errors.FAILURE_TO_MIGRATE_CSV_INTO_TABLE;

  if (DEBUG) {
    console.log(
      `COPY ${cmd_schema} FROM '${path.resolve(
        relpath
      )}' WITH  (FORMAT csv)\n\n`
    );
    console.log(ret);
  }

  return csv_mig_errors.SUCCESSFUL_MIGRATION;
}

export {
  queryDB,
  create_ds_metadata,
  create_ds_frontend,
  generate_schema,
  migrate_csv_to_db_new_table,
  csv_mig_errors,
};
