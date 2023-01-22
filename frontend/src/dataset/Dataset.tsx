import * as React from "react";
import { useState, useEffect } from "react";
import * as ReactDOM from "react-dom/client";
import useVote from "@hooks/useVote";
import Header from "@commons/Header";
import MarkdownRender from "@commons/Markdown";

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
      <div className="black card">
        <h2> {props.name} </h2>
        <h4> {props.description} </h4>
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
  );
}

class ContentCard extends React.Component {
	constructor(props) {
		super(props);
		this.sample_data = null;
		this.readme = null;
		this.issues = null;
		this.tabhtml = null;

		this.state = { tab: 0, loading: true };
		this.renderTab = this.renderTab.bind(this);
	}

	async componentWillMount() {
		(async () => {
			const sdata = await fetch(`http://localhost:3000/dataset/${this.props.ds_name}/sample`);
			this.sample_data = await sdata.json();
			this.sample_data = this.sample_data['rows'];

			const ddata = await fetch(`http://localhost:3000/dataset/${this.props.ds_name}/details?field=readme`);
			const jdata = await ddata.json();
			this.readme = jdata['rows'][0]['readme']
		})().then( () => this.setState({loading: false}));
	}

	renderTab() {
		switch(this.state.tab) {
			// README
			case 0:
				return (
					<div className="readme">
					  {console.log(this.readme)}
						<MarkdownRender children={this.readme}></MarkdownRender>
					</div>
				);
				break;
			// SAMPLE
			case 1:
				var data;
				try {
					data = JSON.stringify(this.sample_data[0]['row_to_json'], undefined, 2);
				} catch(e) {
					console.error(e);
				}
				var tableheaders = [];
				var tabent = [];
				tableheaders = Object.keys(this.sample_data[0]['row_to_json']);
				tableheaders = tableheaders.map( (i) => <th>{i}</th>);
				tableheaders = <tr>{tableheaders}</tr>;

				for(let i of this.sample_data) {
					let ent = [];
					let keys = Object.keys(i['row_to_json']);
					for(let f of keys) {
						ent.push(<td>{i['row_to_json'][f]}</td>)
					}
					tabent.push(<tr>{ent}</tr>)
				}
				return (
								<div className="sample">
									<div className="snippet"> <pre>{data}</pre></div>
									<div className="table"> 
										<table>
											{tableheaders}
											{tabent}
										</table>
									</div>
								</div>
							);
				break;
			// ISSUES
			case 2:
				break;

			// DISCUSSIONS (nostr)
			case 3:
				break;

			default:
				break;
		}
	}

	render() {
		return(
    	<div className="content">
				<div className="buttons">
					<button id={ (this.state.tab === 0) ? "button-clicked" : ""}
					        onClick={ () => this.setState({tab: 0})} >readme</button>
					<button id={ (this.state.tab === 1) ? "button-clicked" : ""}
					        onClick={ () => this.setState({tab: 1})}>sample</button>
					<button id={ (this.state.tab === 2) ? "button-clicked" : ""}
					        onClick={ () => this.setState({tab: 2})}>issues</button>
					<button id={ (this.state.tab === 3) ? "button-clicked" : ""}
					        onClick={ () => this.setState({tab: 3})}>forums</button>
				</div>
    	  { (this.state.loading) ? <p>Loading...</p> : this.renderTab() }
    	</div>
		);
	}
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
          <div className="x">
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
      <p>
        {props.num_entries} entries . {props.file_type} . <strong>{props.file_size}</strong>
      </p>
			<p>{props.num_contrib} contributors</p>
			<div>
				<h3>Owner</h3>
				<div className="owner">
					<div className="owner-pfp"></div>
					<p>owner_name</p>
				</div>
			</div>
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
          cli="127.0.0.1:3000/dataset/43"
					score="69"
        />
				<div className="content">
        	<SideBar
          	about={this.state.desc}
          	num_entries={this.state.num_entries}
						num_contrib="560"
          	file_type="CSV"
          	file_size="456 kB"
          	licence={this.state.licence}
        	/>
					<ContentCard ds_name={this.props.name}/>
				</div>
      </div>
    );
  }
}

const root = ReactDOM.createRoot(document.getElementById("app"));
root.render(<Dataset name={window.ds_name} />);
