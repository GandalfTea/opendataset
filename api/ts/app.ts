import {v4 as uuidv4} from 'uuid';
var assert = require('assert');
const express = require('express')
const app = express()
const PORT: number = 3000;
const DEBUG:boolean = true;
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

app.get('/users', async(req, res) => {
	var rq = await queryDB('SELECT * FROM users;');
	res.send(JSON.stringify(rq['rows']));
});

app.get('/users/:username', async(req: any, res: any) => {
	var username: string = req.params.username;
  var get: any = await queryDB(`SELECT * FROM users WHERE username='${username}';`)
	res.send(`User ${JSON.stringify(get['rows'])}`) })

app.get('/datasets/:dsid', (req, res) => {
	var dsid: number = req.params.dsid;
	res.send(`GET Dataset with UUID ${dsid}`)
})

app.get('/datasets/:dsid/contributions/:hash', (req, res) => {
	var ds = req.params.dsid['uuid'];
	var hash = req.params.hash;
	res.send(`GET contribution ${hash} for dataset ${ds}.`)
})


// CREATE
app.post('/create/dataset', async (req, res) => {
	console.log("POST request")
	const name:string = req.body['name'];
	let   owner:string = await queryDB(`SELECT * FROM users WHERE username='${req.body['owner']}';`);
	const owner:string = owner['rows'][0]['uuid'];
	const schema:string = req.body['schema'];
	switch(req.body['contributions']) {
		case 'all':
			const cont:number = 0;
			break;
		case 'res':
			const cont:number = 1;
			break;
		case 'me' :
			const cont:number = 2;
			break;
	};

	if(DEBUG) console.log(`\nCREATE dataset\n\tName: ${name}\n\tOwner: ${owner}\n\tContributions: ${cont}\n\tSchema: ${schema}`);
	res.send(`Recieved data : ${JSON.stringify(req.body)}`)

	/* TODO
	 [ ] Search DB database to make sure name is unique
	 [x] Search owner in User DB.
	 [ ] protect against injection attacks
	 [ ] parse schema into database creation command
	 [ ] check data format and schema + safety check?
	 [ ] error catching and sending
	 [ ] respond with success */
})

app.post('/create/user', async (req, res) => {
	const username:string = req.body['username'];
	assert(username.length < 50 && username.length > 1);
	const email:string = req.body['email'];
	assert(email.length < 100 && email.length > 10);
	// TODO: Actually check if email is correct lol
	const uuid: string = uuidv4();
	var now = new Date();
	const cakeday: any = now.getFullYear() + '-' + (now.getMonth()+1) + '-' + now.getDate(); 
	console.log(`\n Username: ${username}\n Email: ${email}\n UUID: ${uuid}\n Cakeday: ${cakeday}`)
	const rq = await queryDB(`INSERT INTO users (uuid, username, cakeday, email) 
													  VALUES('${uuid}', '${username}', '${cakeday}', '${email}');`)
	res.send(JSON.stringify(rq))
})

app.listen(PORT, () => {
	console.log(`Example app listening on port ${PORT}`)
})
