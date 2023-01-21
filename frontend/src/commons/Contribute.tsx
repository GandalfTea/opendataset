
import * as React from "react";
import { useState, useEffect } from "react";
import * as ReactDOM from "react-dom/client";
import Header from "@commons/Header";
import MarkdownRender from "@commons/Markdown";

function Guidelines(props) {
	return <div className="black card"><MarkdownRender children={props.guidelines}></MarkdownRender></div>
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
					<div>
						<img src="../assets/upload.svg" alt='Upload file symbol' />
					</div>
				</div>
			</div>
		);
	}
}

function ManualEntry(props) {
	// Generate HTML form from DS schema
	return (
		<div className="card">
			<form>
			</form>
		</div>
	)
}

class ContributePage extends React.Component {
	constructor(props) {
		super(props);
	}

	render() {
		return(
			<div className="page">
				<Header />
				<Guidelines />
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
