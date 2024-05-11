import React from 'react';
import './css/footer.css';
import logo42 from '../assets/42-saopaulo.png';
import logo from '../assets/logo.png';

const Footer = () => {
  return (
    <footer className="footer">
      <div className='footer-col'>
        <img src={logo} className='logo' alt="42 Sao Paulo" />
      </div>
      <div className='footer-col'>
        Developed by caalbert in 42sp with content of Marvel's API Developer This page is made for educational purposes only. All rights reserved to Marvel.<br />
        For this project, I used the Marvel API to get the data of the Avengers<br />
        and Javascript Vanilla+Framework React to build the page.
      </div> 
      <div className='footer-col'>
        <img src={logo42} className='ft' alt="42 Sao Paulo" />
      </div>
    </footer>
  );
};

export default Footer;

