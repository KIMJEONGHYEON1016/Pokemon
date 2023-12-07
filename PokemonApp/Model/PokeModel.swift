//
//  PokeService.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/06.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int?
    let next: String?
    let results: [Pokemon]?
}

struct Pokemon: Codable, Hashable, Equatable {
    var id = UUID()
    let name: String?
    let url: String?
}



struct PokemonSelected: Codable {
    var sprites: PokemonSprites?
    var weight: Int?
}

struct PokemonSprites: Codable {
    var front_default: String
    var other: PokemonOther?
}

struct PokemonOther: Codable {
    var home: PokemonHome?
}

struct PokemonHome: Codable {
    var front_default: String?
}
