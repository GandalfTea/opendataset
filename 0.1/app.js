
const express = require('express')
const app = express()
const port = 3000


/*
 
 Handle:
 * Logins and Session tokens
 * GET requests for datasets
 * Create Pull Requests
 * Accept Pull Requests and update DB


Models:
	User:
		* username - str
		* passward - hash
		* email    - str
		* karma?   - int32
		* Notifications
		* Messages
		* Requests

	Pull Request:
		* Request id - hash
		* new data   - JSON / CVS
		* user       - str
		* status		 - bool + NULL
*/

app.get('/', (req, res) => {
	res.send('Hello')	
})

app.get('/users/:username', (req, res) => {
	var username = req.params.username;
	res.send(`User ${username}`)
})

app.get('/datasets/:uuid', (req, res) => {
	var uuid = req.params.uuid;
	res.send(`GET Dataset with UUID ${uuid}`)
})


app.listen(port, () => {
	console.log(`Example app listening on port ${port}`)
})
