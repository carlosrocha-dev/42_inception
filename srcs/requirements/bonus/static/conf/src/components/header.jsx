import React from 'react';
import './css/header.css';

const Header = () => {
	const handleExploreClick = () => {
		window.location.hash = 'characters';
	};
	return (
		<div className="header">
			<div className="header-content">
				<h1 className="header-title">INCEPTION: BONUS PART</h1>
				<p className="header-subtitle">
					Create a simple static website in the language of your choice.
				</p>
				<div className="header-buttons">
					<button onClick={handleExploreClick} className="btn-explore">
						Explore the characters
					</button>
				</div>
			</div>
		</div>
	);
};

export default Header;
