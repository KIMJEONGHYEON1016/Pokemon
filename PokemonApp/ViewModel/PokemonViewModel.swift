//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/07.
//

import Foundation

class PokemonViewModel {
    private var Pokemon: PokeService
    var PokemonData: Observable<PokemonSelected> = Observable(PokemonSelected(sprites: nil, weight: nil))

    init(_ Pokemon: PokeService) {
        self.Pokemon = Pokemon
    }
    
    //id는 포켓몬 고유 번호
    func fetchMainPokemon(id: Int) {
        let url = URL.urlWith(id: id)
        if let url = url {
            Pokemon.getData(url: url) { [weak self] result in
                switch result {
                case .success(let Data):
                    self?.PokemonData.value = Data
                case .failure(let error):
                    print("Error during fetchMainPokemon: \(error)")
                }
            }
        }
    }
}
