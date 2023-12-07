//
//  PokeSpeciesModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/07.
//

import Foundation

struct PokeSpecies: Codable {
    let names: [Pokemonname]?
}


struct Pokemonname: Codable {
    let name: String?
}
