const express = require("express");
const app = express();
const PORT = 3001;
const DEBUG = false;

app.use(express.static("public"));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.get("/", (req, res) => {
  res.status = 200;
  res.send("Welcome to the frontend server.");
});

app.get("/dataset/:name", (req, res) => {
	
});


app.listen(PORT, () => {
  console.log(`Listening on port: ${PORT}`);
});
