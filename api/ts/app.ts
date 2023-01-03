import {v4 as uuidv4} from 'uuid';
import { queryDB } from './db';
var assert = require('assert');
const express = require('express');
const app = express();
const multer = require('multer');
const PORT: number = 3000;
const DEBUG:boolean = false;



// Setup 
app.use(express.urlencoded({extended: false}));
app.use(express.json());

var cache = multer.diskStorage({
	destination: (req, file, cb) => {
		cb(null, './cache');
	},
	filename: (req, file, cb) => {
		const dsname = file.originalname.split('.')[0];
		cb(null, dsname + '-' + Date.now() + '.csv');
	}
})
var upload = multer({ storage: cache });



app.get('/', (req, res) => {
	res.status = 200; 
	res.send('Hello');	
})



// GET
// TODO: Prevent injection attacks (current is vulnerable)
app.get('/users', async(req, res) => {
	var rq = await queryDB('SELECT * FROM users;');
	res.status = 302;
	res.send(JSON.stringify(rq['rows']));
});

app.get('/users/:username', async(req: any, res: any) => {
	var username: string = req.params.username;
  var get: any = await queryDB(`SELECT * FROM users WHERE username='${username}';`)
	res.status = 302
	res.send(`User ${JSON.stringify(get['rows'])}`) })

app.get('/datasets/:dsid', (req, res) => {
	var dsid: number = req.params.dsid;
	res.status = 302
	res.send(`GET Dataset with UUID ${dsid}`)
})

app.get('/datasets/:dsid/contributions/:hash', (req, res) => {
	var ds = req.params.dsid['uuid'];
	var hash = req.params.hash;
	res.status = 302
	res.send(`GET contribution ${hash} for dataset ${ds}.`)
})



// CREATE
app.post('/create/dataset', upload.single('init'), async (req, res, next) => {

	process.stdout.write(`\tCREATE ds : ${req.socket.remoteAddress} : `);

	const file: any = req.file
	const NO_FILE_UPLOAD: boolean = (!file) ? true : false; 

	const name:string = req.body['name'];
	let   owner_entry:string = await queryDB(`SELECT * FROM users WHERE username='${req.body['owner']}';`);
	if(owner_entry['rowCount'] <= 0) process.stdout.write(`REVOKED, user ${req.body['owner']} not found.`) 
	if(owner_entry['rowCount'] <= 0) {
		res.status = 404;
		res.send(`User not found: ${req.body['owner']}`);
	} else {
		const owner:string = owner_entry['rows'][0]['uuid'];
		const cont:number = parseInt(req.body['contributions']);

		// Auto parse schema from .csv
		const schema:string = req.body['schema'];

		if(!NO_FILE_UPLOAD) {
			/* TODO: Once the file is in local storage
			  [ ] Automatic schema generation
				[ ] Create new table in DB using schema
				[ ] Migrate the data
				[ ] ? Link table to a meta table of contributions
				[ ] ? Register table in metatable of datasets */ 
		}
	
		if(DEBUG) console.log(`\nCREATE dataset\n\tName: ${name}\n\tOwner: ${owner}\n\tContributions: ${cont}\n\tSchema: ${schema}`);
		process.stdout.write(`RESOLVED, dataset '${name}' created.`)
		res.status = 201
		res.send(`Recieved data : ${JSON.stringify(req.body)}`)
	}

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

	console.log(`CREATE user REQUEST from:  ${req.socket.remoteAddress}`)

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
	res.status = 201
	res.send(JSON.stringify(rq))

	/* TODO
	 [ ] Require passward
	 [ ] Check if username already exists
	 [ ] Regex check username
	 [ ] Link to a UserMetadata table for notifications and msg
	 [ ] Verify email
	 [ ] ? Hold pointer to databases created
	 [ ] ? Karma / Rep points */
})


// DELETE
app.delete('/users/:user', async (req, res) => {
	var username: string = req.params.user;
	var query: any = await queryDB(`DELETE FROM users WHERE username='${username}';`);
	res.status = 200 
	res.send(query);

	/* TODO
	  [ ] ? Require some confirmation beforehand (to prevent accidental deletion) */
})

app.listen(PORT, () => {
	console.log(`Listening on port: ${PORT}`)
})
