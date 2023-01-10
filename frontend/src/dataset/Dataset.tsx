import * as React from 'react';
import { useState, useEffect } from 'react';
import * as ReactDOM from 'react-dom/client';
import useVote from '@hooks/useVote';

function VoteButton(props) {
	const [vote, setVote] = useVote(props.vote, props.ds_name);	
	return(
		<button type='button' className='score_button' onClick={ () => setVote(!vote) }>
			<img src={ (vote) ? '@assets/vote_on.svg' : '@assets/vote_off.svg' } 
			     style={ (props.vote=='upvote') ? {transform: 'rotate(180deg)'} : {transform: 'rotate(0deg)'} } />
		</button>
	)
}

function DatasetCard(props) {
	return(
		<div className='address'>
			<div> { props.address } <strong> { props.title } </strong> </div>
			<div className='card'>
				<h2> { props.name } </h2>
				<h5> { props.description } </h5>
				<div className='voting'> 
					<VoteButton vote='upvote' ds_name={props.name} />
					<p>{ /*score*/ } </p>
					<VoteButton vote='downvote' ds_name={props.name} />
				</div>
				<div className='bottom-menu'>
					<p> { props.cli } </p>
					<button onClick={ () => navigator.clipboard.writeText(cli) }></button>
					<button type='button' className='button-empty-white'> <p>Contribute</p> </button>
					<button type='button' className='button-full-white'> <p>Get</p> </button>
				</div>
			</div>
		</div>
	)	
}


function ContentCard(props) {
	const [tab, setTab] = useState(0);

	var tabhtml;
	switch(tab){
		case 0: // README
			tabhtml = <div className=''> { /* MARKDOWN */} </div>
			break;
		case 1: // DATA SNIPPET
			tabhtml = 
				<div className=''>
					<div> { /* Format */} </div>
					<div> { /* First 30 entries */} </div>
				</div>
			break;
		case 2: // CODE EXAMPLES
			tabhtml = <div className=''> { /* Examples */} </div>
			break;
		case 3: // Live discussions
		case 4:	// Issues
			break;
	}

	return(
		<div>
			{/* Buttons */}
			{ tabhtml }
		</div>
	);
}

function SideBar(props) {
	// Switch of type of licence
	var licence: any;
	switch(parseInt(props.licence)){
		case 0: // MIT
			licence =
				<div>
					<h3>MIT Licence</h3> 
					<div><img src={'@assets/tick.svg'} /><p>Commercial Use</p></div> 
					<div><img src={'@assets/tick.svg'} /><p>Private Use</p></div> 
					<div><img src={'@assets/tick.svg'} /><p>Modification</p></div> 
					<div><img src={'@assets/tick.svg'} /><p>Distribution</p></div> 
					<div><img src={'@assets/x.svg'} /><p>Liability</p></div> 
					<div><img src={'@assets/x.svg'} /><p>Warranty</p></div> 
				</div>
	}

	return(
		<div className='side-bar'>
			<h3>About</h3>
			<p>{props.about}</p>
			<p>{props.num_entries} . {props.file_type} . {props.file_size} </p>
			{licence}
		</div>
	)
}

class Dataset extends React.Component {

	constructor(props) {
		super(props);
		this.state = {desc:'', num_entries:0, num_cont:0, licence: 0}
	}

	async componentWillMount() {
		var details;
		await fetch(`http://localhost:3000/dataset/${this.props.name}/details`)
							 .then( response=>response.json())
							 .then( (data) => details=data);
		details = details['rows'][0];
		this.setState({ desc: details['description'], num_entries: details['num_entries'],
		                num_cont: details['num_contributors'], licence: details['licence']});
	}

	render() {
		return (
			<div className='page'>
				<div className='main-content'>
					{console.log(this.state)}
					<DatasetCard address='demo-user/' name={this.props.name} description={this.state.description} cli='' />
				</div>
				<SideBar about='description' num_entries={this.state.num_entries} file_type='CSV' file_size='69Kb' licence={this.state.licence} />
			</div>
		);
	}
}

const root = ReactDOM.createRoot(document.getElementById('app'));
root.render(<Dataset name={window.ds_name}/>);
