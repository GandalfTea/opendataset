
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

function generate_schema(path: string) {
	const python_process = spawn('python', ['./generate_schema_from_pandas.py', path]);
	python_process.stdout.on('data', (data) => {
		return data.toString();
	})
}

// generate_schema('../cache/demo-1672779676422.csv');


async function migrate_csv_to_db_new_table(path: string, table_name:string) {
	const py_schema = generate_schema(path);

	// Parse create schema and command schema
	
	const create_schema = py_schema 
	const cmd_schema = py_schema
	
	queryDB(create_schema);
	queryDB(`COPY ${cmd_schema} FROM ${path} DELIMITER ',' CSV HEADER;`);
}

export { queryDB, generate_schema, migrate_csv_to_db_new_table };
