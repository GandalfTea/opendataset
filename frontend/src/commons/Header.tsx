import * as React from "react";

function Header(props) {
	return(
		<div className="header">
			<p>127.0.0.1<strong>:3001</strong>:0.0.1</p>
			<div className="search">
				<input type="text"></input>
				<img src="../assets/search.svg" />
			</div>
			<div className="profile"></div>
		</div>
	);
}

export default Header;
