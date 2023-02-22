import * as React from "react";
import { useState, useEffect } from "react";
import * as ReactDOM from "react-dom/client";
import Header from "@commons/Header";
//import MarkdownRender from "@commons/Markdown";
import ReactMarkdown from "react-markdown";
import * as env from "@env";

function Guidelines(props) {
  // LaTeX doesn't want to work
  return (
    <div className="guidelines black card">
      <ReactMarkdown>{props.gd}</ReactMarkdown>
    </div>
  );
}

class DropCSV extends React.Component {
  constructor(props) {
    super(props);
    this.state = { drop: false, loading: false, testing: false };
    this.csv_data = "";
		this.filename = "";
		this.filesize = "";
		this.filentries = 0;
    this.drop_handler = this.drop_handler.bind(this);
    this.drag_over_handler = this.drag_over_handler.bind(this);
  }

  drop_handler(e) {
    e.preventDefault();
    this.setState({ loading: true });
    if (e.dataTransfer.items) {
      [...e.dataTransfer.items].forEach((f, i) => {
        if (f.kind === "file") {
          const file = f.getAsFile();
					this.filename = file.name;
					this.filesize = file.size;
          var reader = new FileReader();
          reader.readAsText(file, "UTF-8");
          reader.onload = (e) => {
            this.csv_data = e.target.result.split("\n");
						this.filentries = this.csv_data.length-1;
            this.setState({ loading: false, drop: true });
          };
          reader.onerror = (e) => {
            this.csv_data = "Error Reading File.";
            this.setState({ loading: false, drop: true });
          };
        }
      });
    }
  }

  drag_over_handler(e) {
    e.preventDefault();
  }

  csv_format_handler(f: string) {
    // TODO: Format CSV to look pretty
    f = f.map((s) => <p>{s}</p>);
    if (f.length > 30) {
      return f.slice(0, 30);
    } else {
      return f;
    }
  }

	display_filesize(size: number) {
		if     (size > 1e12) return (size*1e-12).toPrecision(4).toString() + " TB"
		else if (size > 1e9) return (size*1e-9) .toPrecision(4).toString() + " GB"
		else if (size > 1e6) return (size*1e-6) .toPrecision(4).toString() + " MB"
		else if (size > 1e3) return (size*1e-3) .toPrecision(4).toString() + " KB"
		else if (size < 1e3) return size.toString() + " B"
	}

  render() {
		if (this.state.testing) {
			return(
				<div className="testing card">
					<h4>{this.filename}, {this.display_filesize(this.filesize)}, {this.filentries} entries</h4>
					<div>
						{ /* [ ] Find a way to store user tests
						     [ ] Do tests even make sense?  */}
						<h4>Automated Tests</h4>
						<div>
							<img src="../assets/ok.svg" alt='success' />
							<p>Not illegal</p>
						</div>
						<div>
							<img src="../assets/x.svg" alt='fail' />
							<p>Custom test 1</p>
						</div>
					</div>

				</div>
			)

		} else if (this.state.drop) {
      return (
        <div className="file-description card">
					<h4>{this.filename}, {this.display_filesize(this.filesize)}, {this.filentries} entries</h4>
					<div className="file-contents">
          	{this.csv_format_handler(this.csv_data)}
					</div>
					<div>
						<button className="button-empty-black"><p>Next</p></button>
						<button className="button-full-black"
						        onClick={ () => this.setState({drop: false, testing: true})}><p>Done</p></button>
					</div>
        </div>
      );
    } else {
      return (
        <div
          className="card"
          id="drop"
          onDrop={(e) => this.drop_handler(e)}
          onDragOver={(e) => this.drag_over_handler(e)}>
          <div
            className={this.state.loading ? "circle-loading circle" : "circle"}>
            <label for="file">
              <div>
                <img src="../assets/upload.svg" alt="Upload file symbol" />
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
  );
}

class ContributePage extends React.Component {
  constructor(props) {
    super(props);
    this.state = { guidelines: "" };
  }

  async componentWillMount() {
    const cont_guid;
    await fetch(
      `${env.API_URL}/dataset/${this.props.name}/details?q=contribution_guidelines`
    )
      .then((response) => response.json())
      .then((data) => (cont_guid = data["rows"][0]["contribution_guidelines"]));
    this.setState({ guidelines: cont_guid });
  }

  render() {
    return (
			<div className="page">
				<Header />
				<Guidelines gd={this.state.guidelines} />
				<h3>Drag and drop</h3>
				<DropCSV />
				<h3>Manual entry</h3>
				<ManualEntry />
			</div>
    );
  }
}

const root = ReactDOM.createRoot(document.getElementById("app"));
// TODO: Hard Coded dataset name 
root.render(<ContributePage name="second_dataset"/>);
