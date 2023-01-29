
import * as React from "react";
import { useState, useEffect } from "react";
import * as ReactDOM from "react-dom/client";
import Header from "@commons/Header";
//import MarkdownRender from "@commons/Markdown";
import ReactMarkdown from 'react-markdown';

function Guidelines(props) {
	// LaTeX doesn't want to work
	return <div className="guidelines black card"><ReactMarkdown>{props.gd}</ReactMarkdown></div>
}

class DropCSV extends React.Component {
	constructor(props){
		super(props);
		this.state = { drop: false, loading: false };
		this.drop_handler = this.drop_handler.bind(this);
		this.drag_over_handler = this.drag_over_handler.bind(this);
	}

	drop_handler(e){
		e.preventDefault();
		this.setState({loading: true})
		if(e.dataTransfer.items) {
			[...e.dataTransfer.items].forEach( (f, i) => {
				if(f.kind === 'file') {
					const file = f.getAsFile();
					// Get contents of file
				}
			});
		}
	}

	drag_over_handler(e){
		e.preventDefault();
	}

	render() {
		if(this.state.drop) {
			return(
				<div className="card"> { /* CSV data */}</div>
			);
		} else {
			return(
				<div className="card" 
			   	   id="drop"
			   	   onDrop={ (e) => this.drop_handler(e)}
						 onDragOver={ (e) => this.drag_over_handler(e)}>
					<div className={ (this.state.loading) ? "circle-loading circle" : "circle" }>
						<label for="file">
							<div>
								<img src="../assets/upload.svg" alt='Upload file symbol' />
							</div>
						</label>
							<input type="file" id="file" accept="application/json, .csv" />
			 		</div>
				</div>
			);
		}
	}
}

function ManualEntry(props) {
	// Generate HTML form from DS schema
	return (
		<div className="card">
			<p>TODO: Generate form from schema</p>
		</div>
	)
}

class ContributePage extends React.Component {
	constructor(props) {
		super(props);
		this.state = {guidelines: ""};
	}

	async componentWillMount() {
		const cont_guid
		await fetch("http://127.0.0.1:3000/dataset/second_dataset/details?q=contribution_guidelines")
		            .then( (response) => response.json())
								.then( (data) => cont_guid = data['rows'][0]['contribution_guidelines'] );
		this.setState({guidelines: cont_guid});
	}

	render() {
		return(
			<div className="page">
				<Header />
				<Guidelines gd={this.state.guidelines} />
				<h3>Drag and drop</h3>
				<DropCSV />
				<h3>Manual entry</h3>
				<ManualEntry />
			</div>
		)
	}
}

const root = ReactDOM.createRoot(document.getElementById("app"));
root.render(<ContributePage />);
