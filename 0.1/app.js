
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
	res.send('Landing Page if not logged in \n Notifications page if logged in.')
})

app.get('/login', (req, res) => {
	res.send('Login Page')
})

app.get('/dataset', (req, res) => {
	res.send('Load dataset with SLUG or HASH')
})

app.listen(port, () => {
	console.log(`Example app listening on port ${port}`)
})
