import React from 'react';
import './css/navbar.css';
import logo from '../assets/logo.png';

const Navbar = () => {
	return (
		<nav className="navbar">
			<div className="navbar-header">
				<img src={logo} alt="Logo" className="navbar-logo" />
				<h1 className="navbar-title">MCU - Avengers Index</h1>
			</div>
			<div className="nav-links">
				<a href="/" className="nav-item active">Caalbert`s Inception project</a>
				<a href="#characters" className="nav-item">The avengers</a>
			</div>
		</nav>
	);
};

export default Navbar;
