//
//  URL+Extension.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/07.
//

import UIKit

extension URL {
    static func urlWith(id: Int) -> URL? {
        return URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")
    }
    
}

extension URL {
    static func urlWithsepc(id: Int) -> URL? {
        return URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/")
    }
    
}


