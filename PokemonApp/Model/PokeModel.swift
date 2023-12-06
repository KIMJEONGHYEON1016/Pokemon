//
//  PokeService.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/06.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable, Hashable, Equatable {
    var id = UUID()
    let name: String
    let url: String
}


struct DetailPokemon: Codable{
    let id: Int
    let height: Int
    let weight: Int
}

struct PokemonSelected: Codable {
    var sprites: PokemonSprites
    var weight: Int
}

struct PokemonSprites: Codable {
    var front_default: String
}
