import * as React from 'react';
import * as ReactDOM from 'react-dom/client';

class Dataset extends React.Component {
	constructor(props) {
		super(props);
	}
	render() {
		return <h1>{this.props.msg}</h1>;
	}
}

const root = ReactDOM.createRoot(document.getElementById('app'));
root.render(<Dataset msg={window.ds_name}/>);
