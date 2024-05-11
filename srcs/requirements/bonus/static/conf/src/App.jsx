import React from 'react';
import Avengers from './components/avengers';
import Header from './components/header';
import Navbar from './components/navbar';
import Footer from './components/footer';
import './App.css';

function App() {
  return (
    <div className="App">
      <Navbar />
      <Header title="Avengers" />
      <Avengers />
      <Footer />
    </div>
  );
}

export default App;