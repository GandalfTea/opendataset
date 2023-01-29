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
    this.state = { drop: false, loading: false };
    this.csv_data = "";
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
          var reader = new FileReader();
          reader.readAsText(file, "UTF-8");
          reader.onload = (e) => {
            this.csv_data = e.target.result.split("\n");
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

  render() {
    if (this.state.drop) {
      return (
        <div className="file-contents card">
          {this.csv_format_handler(this.csv_data)}
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
