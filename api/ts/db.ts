
const { Client } = require('pg')

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

async function generate_schema(path: string) {
	const python_process = spawn('python', ['./ts/generate_schema_from_pandas.py', path]);
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

async function migrate_csv_to_db_new_table(path: string, table_name:string) {
	const py_schema = await generate_schema(path);
	//console.log(py_schema)
	//queryDB(create_schema);
	//queryDB(`COPY ${cmd_schema} FROM ${path} DELIMITER ',' CSV HEADER;`);
	return py_schema.toString();
}

export { queryDB, generate_schema, migrate_csv_to_db_new_table };
