
import * as React from "react";
import { useState, useEffect } from "react";
import * as ReactDOM from "react-dom/client";
import Header from "@commons/Header";
import MarkdownRender from "@commons/Markdown";

function Guidelines(props) {
	// Markdown doesn't want to work
	//return <div className="black card"><MarkdownRender children={props.gd}></MarkdownRender></div>
	return <div className="guidelines black card"><p>{props.gd}</p></div>
}

function DropCSV(props) {
	const [file, setFile] = useState(false); 
	
	if(file) {
		// Show CSV
		return(
			<div className="black card">
				<pre>{ /* CSV DATA */}</pre>
			</div>
		);
	} else {
		return (
			<div className="card" 
			     id="drop"
			     onDrop={/*do something*/}
					 onDragOver={ /* do something */}>
				<div className="circle">
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
