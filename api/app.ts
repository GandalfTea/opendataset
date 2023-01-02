const express = require('express')
const app = express()
const PORT: number = 3000;
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
		const res: any = await client.query(query)
		await client.end()
		return res;
	} catch(error) {
		return error
	}
}

app.get('/', (req, res) => {
	res.send('Hello')	
})


// GET
app.get('/users/:username', async(req: any, res: any) => {
	var username: string = req.params.username;
  var get: any = await queryDB('SELECT * from USERS')
	res.send(`User ${JSON.stringify(get['rows'])}`) })

app.get('/datasets/:dsid', (req, res) => {
	var dsid: number = req.params.dsid;
	res.send(`GET Dataset with UUID ${dsid}`)
})

app.get('/datasets/:dsid/contributions/:hash', (req, res) => {
	var ds = req.params.dsid;
	var hash = req.params.hash;
	res.send(`GET contribution ${hash} for dataset ${ds}.`)
})


// CREATE
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

app.post('/create/user', (req, res) => {
	res.send(req.body)
})

app.listen(PORT, () => {
	console.log(`Example app listening on port ${PORT}`)
})
