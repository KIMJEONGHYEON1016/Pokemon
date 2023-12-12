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
    var back_default: String
    var versions: PokemonVersions?
}

struct PokemonOther: Codable {
    var home: PokemonHome?
}

struct PokemonHome: Codable {
    var front_default: String?
}


struct PokemonVersions: Codable {
    var generation_v: PokemonGenerationV?
}
struct PokemonGenerationV: Codable {
    var black_white: PokemonBlackWhite?
}

struct PokemonBlackWhite: Codable {
    var animated: PokemonAnimated?
}
struct PokemonAnimated: Codable {
    var back_default: String
   
}
