import { v4 as uuidv4 } from "uuid";
require("dotenv").config();
import {
  queryDB,
  generate_schema,
  migrate_csv_to_db_new_table,
  csv_mig_errors,
} from "./db";

var assert = require("assert");
const express = require("express");
const session = require("express-session");
const pgSession = require("connect-pg-simple")(session);

// Setup

const app = express();
const PORT: number = 3000;
const DEBUG: boolean = false;

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

const store = new pgSession({
  conString: `postgres://${process.env.PGUSER}:${process.env.PGPASSWORD}@${process.env.PGHOST}:${process.env.PGPORT}/${process.env.PGDATABASE}`,
});

app.use(
  session({
    store: store,
    secret: "catsridingbikesonspikeslikereichs",
    saveUninitialized: false,
    resave: false,
    cookie: {
      secure: false, // localhost no https
      maxAge: 1000 * 60 * 60,
    },
  })
);

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
