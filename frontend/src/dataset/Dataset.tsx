import * as React from "react";
import { useState, useEffect } from "react";
import * as ReactDOM from "react-dom/client";
import useVote from "@hooks/useVote";
import Header from "@commons/Header";

function Vote(props) {
	const [vote, setVote] = useState(0);
	const [voted, setVoted] = useState(false); // Not sure if this needs to be in state 
	useEffect( () => {
		//var url = process.env.REACT_APP_BASE_URL;
		var url = 'http://localhost:3000';
		if(vote > 0){
			setVoted(true);
			(vote === 1) ? `/upvote?ds=` : `/downvote?ds=`;
			url += props.ds_name;
			fetch(url, { method: 'POST' }); 
		} else if (vote === 0 && voted) {
			fetch(url, { method: 'DELETE' });    // Retract vote
			setVoted(false);
		}
	})

	return(
		<div className='voting'>
						<button type="button" className="score_button" onClick={ () => (vote===1) ? setVote(0) : setVote(1) }>
							<img src={ (vote===1) ? '../assets/vote_on.svg' : '../assets/vote_off.svg'}
									 style={ {transform: "rotate(180deg)"} } />
						</button>
						<p>{ (vote===1) ? props.score+1 : (vote===2) ? props.score-1 : props.score }</p>
						<button type="button" className="score_button" onClick={ () => (vote===2) ? setVote(0) : setVote(2) }>
							<img src={ (vote===2) ? '../assets/vote_on.svg' : '../assets/vote_off.svg'}>
						</button>
		</div>
	)
}

function DatasetCard(props) {
  return (
    <div className="address">
      {props.address} <strong> {props.title} </strong>
      <div className="card">
        <h2> {props.name} </h2>
        <h4> {props.description} {props.description} {props.description} </h4>
				<Vote ds_name='demo-dataset' score={69} />
        <div className="bottom-menu">
					<div> 
						<p> {props.cli} </p> 
          	<button onClick={() => navigator.clipboard.writeText(cli)}><img src="../assets/clipboard.svg" alt='copy to clipboard' /></button>
					</div>
          <button type="button" className="button-empty-white">
            <p>Contribute</p>
          </button>
          <button type="button" className="button-full-white">
            <p>Get</p>
          </button>
        </div>
      </div>
    </div>
  );
}

function ContentCard(props) {
  const [tab, setTab] = useState(0);

  var tabhtml;
  switch (tab) {
    case 0: // README
      tabhtml = <div className=""> {/* MARKDOWN */} </div>;
      break;
    case 1: // DATA SNIPPET
      tabhtml = (
        <div className="">
          <div> {/* Format */} </div>
          <div> {/* First 30 entries */} </div>
        </div>
      );
      break;
    case 2: // CODE EXAMPLES
      tabhtml = <div className=""> {/* Examples */} </div>;
      break;
    case 3: // Live discussions
    case 4: // Issues
      break;
  }

  return (
    <div>
      {/* Buttons */}
      {tabhtml}
    </div>
  );
}

function SideBar(props) {
  // Switch of type of licence
  var licence: any;
  switch (parseInt(props.licence)) {
    case 0: // MIT
      licence = (
        <div>
          <h3>MIT Licence</h3>
          <div>
            <img src={"../assets/tick.svg"} />
            <p>Commercial Use</p>
          </div>
          <div>
            <img src={"../assets/tick.svg"} />
            <p>Private Use</p>
          </div>
          <div>
            <img src={"../assets/tick.svg"} />
            <p>Modification</p>
          </div>
          <div>
            <img src={"../assets/tick.svg"} />
            <p>Distribution</p>
          </div>
          <div>
            <img src={"../assets/x.svg"} />
            <p>Liability</p>
          </div>
          <div>
            <img src={"../assets/x.svg"} />
            <p>Warranty</p>
          </div>
        </div>
      );
  }

  return (
    <div className="side-bar">
      <h3>About</h3>
      <p>{props.about}</p>
      <p>
        {props.num_entries} . {props.file_type} . {props.file_size}{" "}
      </p>
      {licence}
    </div>
  );
}

class Dataset extends React.Component {
  constructor(props) {
    super(props);
    this.state = { desc: "", num_entries: 0, num_cont: 0, licence: 0 };
  }

  async componentWillMount() {
    var details;
    await fetch(`http://localhost:3000/dataset/${this.props.name}/details`)
      .then((response) => response.json())
      .then((data) => (details = data));
    details = details["rows"][0];
    this.setState({
      desc: details["description"],
      num_entries: details["num_entries"],
      num_cont: details["num_contributors"],
      licence: details["licence"],
    });
  }

  render() {
    return (
      <div className="page">
				<Header />
        <DatasetCard
          address="demo-user/"
          name={this.props.name}
          description={this.state.desc}
          cli="127.0.0.1:3000/dataset/43/data"
					score="69"
        />
				<div className="content">
        	<SideBar
          	about={this.state.desc}
          	num_entries={this.state.num_entries}
          	file_type="CSV"
          	file_size="69Kb"
          	licence={this.state.licence}
        	/>
					<ContentCard />
				</div>
      </div>
    );
  }
}

const root = ReactDOM.createRoot(document.getElementById("app"));
root.render(<Dataset name={window.ds_name} />);
