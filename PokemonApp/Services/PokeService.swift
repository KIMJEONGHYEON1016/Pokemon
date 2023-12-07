//
//  PokeService.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/06.
//

import Foundation

class PokeService {
    func getData(url: String, completion: @escaping (Result<PokemonSelected, Error>) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            guard let data = data else { return }
            
            do {
                let pokemonSelected = try JSONDecoder().decode(PokemonSelected.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(pokemonSelected))
                }
            } catch {
                print("Error decoding JSON:", error)
                DispatchQueue.main.async {
                    completion(.failure(error)) // JSON 디코딩 실패 시 nil을 반환하거나 적절한 오류 처리
                }
            }
        }.resume()
    }
}


