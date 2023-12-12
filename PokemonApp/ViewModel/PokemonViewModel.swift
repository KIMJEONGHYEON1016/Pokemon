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
    
    @Published var PokemonData: PokemonData?
    @Published var PokemonSpecies: PokeSpecies?
    @Published var WildPokemonData: PokemonData?
    @Published var PartnerPokemonPower: PokemonData?
    @Published var WildPokemoPower: PokemonData?

    
    init(_ Pokemon: PokeService) {
        self.Pokemon = Pokemon
    }

    
    
    // id는 포켓몬 고유 번호
    func fetchPokemon(id: Int) {
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
   
    
    func fetchWildPokemon(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.WildPokemonData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchPokemonName(id: Int) {
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
    
    
    func fetchPartnerPokemonPower(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }
        
        Pokemon.getData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PartnerPokemonPower = data
            })
            .store(in: &cancellables)
    }
    
    func fetchWildPokemonpower(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.WildPokemoPower = data
            })
            .store(in: &cancellables)
    }
}
