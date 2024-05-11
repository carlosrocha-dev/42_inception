import React, { useEffect, useState } from 'react';
import './css/avengers.css';

const Avengers = () => {
    const [heroes, setHeroes] = useState([]);

    useEffect(() => {
        fetch('/avengersData.json')
            .then(response => response.json())
            .then(data => setHeroes(data))
            .catch(error => console.error("Erro ao carregar dados dos Vingadores:", error));
    }, []);

    const scrollToTop = () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    };

    return (
        <div className="card-container" id="characters">
            {heroes.map((hero) => (
                <div className="card" key={hero.id}>
                    <img src={`${hero.thumbnail.path}.${hero.thumbnail.extension}`} alt={hero.name} />
                    <h2 className="card-title">{hero.name}</h2>
                    <p className="card-text">{hero.description || 'Descrição não disponível'}</p>
                    <div className="comics-list">
                        {hero.comics.map((comic, index) => (
                            <div className="comic" key={index}>
                                <h4 className="card-title">Comic name: </h4>
                                <div className="comic-info">
                                    <h3 className="comic-name">{comic.name}</h3>
                                    <p className="comic-year">{comic.year}</p>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            ))}
            <button onClick={scrollToTop} className="btn-top">
                ↑ Top
            </button>
        </div>
    );
};

export default Avengers;
