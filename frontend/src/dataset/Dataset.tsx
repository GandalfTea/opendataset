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
	useEffect( () => {
		var dick = true;
		// Request data from ds_frontend
	});

	var address = 'dicks'
	var description = 'desc'
	var cli = 'https://pornhub.com'

	return(
		<div className='address'>
			<div> { address } <strong> { props.title } </strong> </div>
			<div className='card'>
				<h2> { props.name } </h2>
				<h3> { description } </h3>
				<div className='voting'> 
					<VoteButton vote='upvote' ds_name={props.name} />
					<p>{ /*score*/ } </p>
					<VoteButton vote='downvote' ds_name={props.name} />
				</div>
				<div>
					<p> { cli } </p>
					<button onClick={ () => navigator.clipboard.writeText(cli) }></button>
					<button type='button'> <p>Contribute</p> </button>
					<button type='button'> <p>Get</p> </button>
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
					<h5>MIT Licence</h5> 
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
			<h4>About</h4>
			<p>{props.about}
			<p>{props.num_entries} . {props.file_type} . {props.file_size} </p>
			<p>{licence}</p>
		</div>
	)
}

class Dataset extends React.Component {
	constructor(props) {
		super(props);
	}
	render() {
		return (
			<div>
				<div>
					<DatasetCard title={this.props.name} />
				</div>
				<SideBar about='description' num_entries='50000' file_type='CSV' file_size='69Kb' licence='0' />
			</div>
		);
	}
}

const root = ReactDOM.createRoot(document.getElementById('app'));
root.render(<Dataset name={window.ds_name}/>);
