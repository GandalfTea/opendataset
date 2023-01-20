import * as React from "react";

function Header(props) {
	return(
		<div className="header">
			<p>open<strong>dataset</strong></p>
			<div className="search">
				<input type="text"></input>
				<img src="../assets/search.svg" />
			</div>
			<div className="profile"></div>
		</div>
	);
}

export default Header;
