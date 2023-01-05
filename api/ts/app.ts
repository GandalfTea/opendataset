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
import { router as create_routes } from "./create.routes";
import { router as users_routes } from "./users.routes";
import { router as datasets_routes } from "./datasets.routes";
app.use("/create", create_routes);
app.use("/users", users_routes);
app.use("/datasets", datasets_routes);

// GET
app.listen(PORT, () => {
  console.log(`Listening on port: ${PORT}`);
});
