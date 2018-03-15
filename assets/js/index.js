// ENTRY POINT FOR REACT
import 'phoenix_html';
import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
// components

class App extends React.Component {
	render() {
		return (
			<div>
				<h1>I'm a react component</h1>
			</div>
		);
	}
}

ReactDOM.render(<App />, document.getElementById('mount'));
