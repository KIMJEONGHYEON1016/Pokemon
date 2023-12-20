//
//  PokeSpeciesModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/07.
//

import Foundation

struct PokeSpecies: Codable {
    let names: [Pokemonname]?
    let genera: [Pokemongenus]?
    let flavor_text_entries: [Pokemontext]?
}


struct Pokemontext: Codable {
    let flavor_text: String?
    let language: PokemonLanguage
}

struct PokemonLanguage: Codable {
    let name: String
    let url: String
}

struct Pokemongenus: Codable {
    let genus: String?
}


struct Pokemonname: Codable {
    let name: String?
}


struct Enemy {
    var hp: Int
    var defense: Int
    var attack: Int
}


struct Partner {
    var hp: Int
    var defense: Int
    var attack: Int
}
