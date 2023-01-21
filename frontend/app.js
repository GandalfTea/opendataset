const path = require("path");
const express = require("express");

const app = express();

const PORT = 3001;
const DEBUG = false;

app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'public', 'views')); 

app.use(express.static("public"));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.get("/", (req, res) => {
  res.status = 200;
  res.send("Welcome to the frontend server.");
});

app.get("/dataset/:name", (req, res) => {
	//res.sendFile(path.join(__dirname, "public", "dataset", "dataset.html"));	
	res.render('dataset', {name: req.params.name, message:'Welcome to the dataset page'});
});

app.get("/contribute", (req, res) => {
	res.render('contribute');
})

app.listen(PORT, () => {
  console.log(`Listening on port: ${PORT}`);
});
