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

class Dataset extends React.Component {
	constructor(props) {
		super(props);
	}
	render() {
		return <DatasetCard title={this.props.name} />;
	}
}

const root = ReactDOM.createRoot(document.getElementById('app'));
root.render(<Dataset name={window.ds_name}/>);
