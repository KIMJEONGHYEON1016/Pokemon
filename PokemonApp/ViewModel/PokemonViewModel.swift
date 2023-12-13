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
    //파트너 포켓몬 이미지
    func fetchPokemon(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonData = data
            })
            .store(in: &cancellables)
    }
   
    
    //야생 포켓몬 이미지
    func fetchWildPokemon(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.WildPokemonData = data
            })
            .store(in: &cancellables)
    }
    
    //포켓몬 한글 이름
    func fetchPokemonName(id: Int) {
        let url = URL.urlWithsepc(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemonName: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonSpecies = data
            })
            .store(in: &cancellables)
    }
    
    
    //파트너 포켓몬 스텟
    func fetchPartnerPokemonPower(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }
        
        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PartnerPokemonPower = data
            })
            .store(in: &cancellables)
    }
    
    
    //야생 포켓몬 스텟
    func fetchWildPokemonpower(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
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
