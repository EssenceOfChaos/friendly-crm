// ENTRY POINT FOR REACT
import 'phoenix_html';
import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
// components
import Header from './components/header';

class App extends React.Component {
	render() {
		return (
			<div>
				<Header />
			</div>
		);
	}
}

ReactDOM.render(<App />, document.getElementById('mount'));
