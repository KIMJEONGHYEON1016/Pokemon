//
//  URL+Extension.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/07.
//

import Foundation

extension URL {
    static func urlWith(id: Int) -> String? {
        return String("https://pokeapi.co/api/v2/pokemon/\(id)/")
    }
    
}
