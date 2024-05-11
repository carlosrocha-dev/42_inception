import fs from 'fs';
import path from 'path';
import axios from 'axios';
import md5 from 'md5';
import dotenv from 'dotenv';

dotenv.config();

const publicKey = process.env.PUBLIC_KEY;
const privateKey = process.env.PRIVATE_KEY;
const baseUrl = 'https://gateway.marvel.com/v1/public/characters';

const avengersCharacters = [
    "Iron Man",
    "Captain America",
    "Thor",
    "Hulk",
    "Black Widow",
    "Hawkeye",
    "Scarlet Witch",
    "Vision",
    "Falcon",
    "Winter Soldier",
    "Spider-Man (Peter Parker)",
    "Doctor Strange",
    "Black Panther",
    "Wasp",
    "Gamora",
    "Drax",
    "Rocket Raccoon",
    "Groot",
    "Mantis",
    "Nebula",
    "Nick Fury",
    "Maria Hill",
];

async function fetchCharacterData(name) {
    const time = new Date().getTime();
    const hash = md5(time + privateKey + publicKey);

    try {
        const response = await axios.get(baseUrl, {
            params: {
                ts: time,
                apikey: publicKey,
                hash: hash,
                name: name,
            }
        });
        const character = response.data.data.results[0];

        if (!character) {
            console.warn(`Nenhum dado encontrado para ${name}`);
            return null;
        }

        const comics = character.comics ? character.comics.items.map(comic => {
            const comicId = comic.resourceURI.match(/\/(\d+)$/)[1];
            return {
                id: comicId,
                name: comic.name,
                resourceURI: comic.resourceURI
            };
        }) : [];

        return {
            ...character,
            comics: comics,
        };
    } catch (error) {
        console.error(`Erro ao buscar dados para ${name}:`, error);
        return null;
    }
}


async function main() {
    const promises = avengersCharacters.map(name => fetchCharacterData(name));
    const charactersData = await Promise.all(promises);
    const filteredData = charactersData.filter(Boolean);

    fs.writeFileSync(path.join(process.cwd(), 'public', 'avengersData.json'), JSON.stringify(filteredData, null, 2));
    console.log('Dados dos Vingadores salvos em public/avengersData.json');
}

main();
