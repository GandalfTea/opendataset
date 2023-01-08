
import { queryDB } from "../db";

const express = require("express");
const upvote_router = express.Router();

// www.api.demo.com/upvote?ds=demo-dataset
upvote_router.post('/', async (req, res) => {	
	const ds = req.query.ds;
	// post to db db_metadata
})

upvote_router.delete('/', async (req, res) => {
	const ds = req.query.ds;
	// check if user has voted, if yes remove vote
})

const downvote_router = express.Router();

downvote_router.post('/', async (req, res) => {
	const ds = req.query.ds;
	// . . .
})

downvote_router.delete('/', async (req, res) => {
	const ds = req.query.ds;
	// . . . 
})
		
