import { v4 as uuidv4 } from "uuid";
import {
  queryDB,
  generate_schema,
  migrate_csv_to_db_new_table,
  csv_mig_errors,
} from "./db";

var assert = require("assert");
const express = require("express");
const app = express();
const PORT: number = 3000;
const DEBUG: boolean = false;

// Setup
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.get("/", (req, res) => {
  res.status = 200;
  res.send("Hello");
});

// Routes
import { router as create_routes } from "./routes/create.routes";
import { router as users_routes } from "./routes/users.routes";
import { router as datasets_routes } from "./routes/datasets.routes";
import { router as login_routes } from "./routes/login.routes";
app.use("/create", create_routes);
app.use("/user", users_routes);
app.use("/dataset", datasets_routes);
app.use("/ds", datasets_routes);
app.use("/login", login_routes);

app.listen(PORT, () => {
  console.log(`Listening on port: ${PORT}`);
});
