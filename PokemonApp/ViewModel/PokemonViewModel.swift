//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/07.
//

import Foundation
import Combine

class PokemonViewModel {
    private var Pokemon: PokeService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var PokemonData: PokemonSelected?
    @Published var PokemonSpecies: PokeSpecies?

    init(_ Pokemon: PokeService) {
        self.Pokemon = Pokemon
    }

    // id는 포켓몬 고유 번호
    func fetchMainPokemon(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonData = data
            })
            .store(in: &cancellables)
    }

    func fetchMainPokemonName(id: Int) {
        let url = URL.urlWithsepc(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemonName: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonSpecies = data
            })
            .store(in: &cancellables)
    }
}
