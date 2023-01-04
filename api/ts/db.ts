
const { Client } = require('pg')
const path = require('path');

const queryDB = async(query) => {
	try {
			const client = new Client({
					user: 'su',
					host: '127.0.0.1',
					database: 'api',
					password: 'lafiel',
					port: '5432'
				})
		await client.connect()
		const res: any = await client.query(query)
		await client.end()
		return res;
	} catch(error) {
		return error
	}
}


// Parse recieved .cvs files and upload them to the database

const spawn = require('child_process').spawn;
const execSync = require('child_process').execSync;

/*
	The current schema automation takes the first row as the names of the columns
	The responsability for this will fall on the user. Future contributions after
	the dataset was created will not have this restriction 

	In : .csv filename
  Inside : hardcoded the location of the cache file and py script
  Out : bstring of schema as generated by pandas  */

async function generate_schema(path: string, name:string) {
	try{
		var python_process = spawn('python', ['./ts/generate_schema_from_pandas.py', path, name]);
	} catch(e) { throw new Error(e)}

	return new Promise((resolve, reject) => {
		python_process.stderr.on('data', (data) => {
			process.stdout.write(data.toString());
		})
		python_process.on('close', (code) => {
			console.log("Python child process finished : " + code);
		})
		python_process.stdout.on('data', (data) => {
			resolve(data)
		})
	})
}

enum csv_mig_errors {
	SUCCESSFUL_MIGRATION,
	ERROR_GENERATING_SCHEMA,
	ERROR_GENERATING_DB_COMMANDS,
	ERROR_ILLEGAL_COLUMN_NAMES,
	FAILURE_TO_GENERATE_TABLE,
	FAILURE_TO_MIGRATE_CSV_INTO_TABLE
};

async function migrate_csv_to_db_new_table(relpath: string, table_name:string, DEBUG:boolean = false){
	try{
		var py_schema = await generate_schema(relpath, table_name);
	} catch(e) { return csv_mig_errors.ERROR_GENERATING_SCHEMA; }

	const name = relpath.split('-')[0];
	relpath = './cache/'+relpath

	try{

		var split_schema: string[] = py_schema.toString().split('(')[1].split(')')[0].split(',');
		var fields: string[] = []; 
	
		for( let i=0; i < split_schema.length; i++) {
			if( /^[a-zA-Z_][a-zA-Z0-9#$@]+/.test(split_schema[i].split('"')[1])) {
				fields.push(split_schema[i].split('"')[1]);
			} else {
				return csv_mig_errors.ERROR_ILLEGAL_COLUMN_NAMES;
			}
		}
		var cmd_schema = `${name}(`;
		for( let i=0; i < fields.length; i++ ){
			cmd_schema += (i == fields.length-1) ? fields[i] : fields[i]+", ";
		}
		cmd_schema += ")"
	} catch(e) { return csv_mig_errors.ERROR_GENERATING_DB_COMMANDS; }

	//console.log(`COPY ${cmd_schema} FROM '${path.resolve(relpath)}' WITH  (FORMAT csv)\n\n`)

	var ret:string = await queryDB(py_schema.toString());
	if (false /* check if ret is good*/) return csv_mig_errors.FAILURE_TO_GENERATE_TABLE;

	ret = await queryDB(`COPY ${cmd_schema} FROM '${path.resolve(relpath)}' DELIMITER ',' CSV HEADER;`);
	if (false /* check if ret is good*/) return csv_mig_errors.FAILURE_TO_MIGRATE_CSV_INTO_TABLE;

	console.log(ret)
	return csv_mig_errors.SUCCESSFUL_MIGRATION;
}

export { queryDB, generate_schema, migrate_csv_to_db_new_table, csv_mig_errors };
