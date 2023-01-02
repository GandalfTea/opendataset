
const express = require('express')
const app = express()
const port = 3000
app.use(express.urlencoded({extended: false}));
app.use(express.json());


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
		const res = await client.query(query)
		console.log(res)
		await client.end()
		return res;
	} catch(error) {
		return error
	}
}

/*
 
 USE: PostgreSQL DB to store Users and Datasets + Metadata
 
 Handle:
 * Logins and Session tokens. Maybe no pass login?
 * GET requests for datasets
 * Create Pull Requests
 * Accept Pull Requests and update DB
 
*/

app.get('/', (req, res) => {
	res.send('Hello')	
})

app.get('/users/:username', async(req, res) => {
	var username = req.params.username;
  var get = await queryDB('SELECT * from USERS')
	res.send(`User ${JSON.stringify(get['rows'])}`) })

app.get('/datasets/:dsid', (req, res) => {
	var dsid = req.params.dsid;
	res.send(`GET Dataset with UUID ${dsid}`)
})


/* Create new dataset

 Expected JSON req data:
 {
		username: char[16]
		schema: JSON
		plan: int4
		initial_data: JSON
 }
*/

app.post('/create/dataset', (req, res) => {
	console.log("POST request")
	res.send(`Recieved data : ${JSON.stringify(req.body)}`)


	/* TODO
	 * protect against injection attacks
	 * parse schema into database creation command
	 * check data format and schema + safety check?
	 * error catching and sending
	 * respond with success */
})

/* Create new User 

 Expected JSON req data:
 {
		username: char[16]
		passward: hash[256]
		? email: char[16]
		? RSS : hash[256]
 }
*/
app.post('/create/user', (req, res) => {
	res.send(req.body)
})

app.get('/datasets/:dsid/contributions/:hash', (req, res) => {
	var ds = req.params.dsid;
	var hash = req.params.hash;
	res.send(`GET contribution ${hash} for dataset ${ds}.`)
})


app.listen(port, () => {
	console.log(`Example app listening on port ${port}`)
})
