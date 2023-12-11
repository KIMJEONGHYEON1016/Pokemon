//
//  PokeService.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/06.
//

import Foundation
import Combine

class PokeService {
    func getData<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


