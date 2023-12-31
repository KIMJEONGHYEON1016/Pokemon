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
    @Published var WildPokemonPower: PokemonData?
    @Published var allPokemonNames: [String] = []
    @Published var allPokemonTypes: [[String]] = []
    @Published var Pokemongenera: PokeSpecies?
    @Published var PokemonWeight: PokemonData?
    @Published var PokemonHeight: PokemonData?
    @Published var PokemonText: PokeSpecies?

    
    
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
    
    //포켓몬도감 이름
    func fetchAllPokemonNames(index: Int = 1) {
        guard index <= 151 else {
            // 모든 요청이 완료된 경우
            UserDefaults.standard.set(self.allPokemonNames, forKey: "allPokemonNames")
            return
        }
        
        let url = URL.urlWithsepc(id: index)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchAllPokemonNames: \(error)")
                }
            }, receiveValue: { (data: PokeSpecies?) in
                if let name = data?.names?[2].name {
                    self.allPokemonNames.append(name)
                }
                
                // 다음 포켓몬 데이터 요청을 수행
                self.fetchAllPokemonNames(index: index + 1)
            })
            .store(in: &cancellables)
    }

    //포켓몬 도감 타입
    func fetchAllPokemonTypes(index: Int = 1) {
            guard index <= 151 else {      
                let koreanType = convertToKorean(types: allPokemonTypes)
                UserDefaults.standard.set(koreanType, forKey: "allPokemonTypes")
                return
            }
            
            let url = URL.urlWith(id: index)
            guard let url = url else { return }

            Pokemon.getData(url: url)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error during fetchAllPokemonTypes: \(error)")
                    }
                }, receiveValue: { (data: PokemonData?) in
                    if let types = data?.types {
                        let pokemonTypes = types.compactMap { $0.type?.name }
                        self.allPokemonTypes.append(pokemonTypes)
                    } else {
                        // 해당 포켓몬에 타입 데이터가 없는 경우에 대한 처리
                        self.allPokemonTypes.append([])
                    }
                    
                    // 다음 포켓몬 데이터 요청을 수행
                    self.fetchAllPokemonTypes(index: index + 1)
                })
                .store(in: &cancellables)
        }
    //타입 한글로 변환
    func convertToKorean(types: [[String]]) -> [[String]] {
        return types.map { innerArray in
            innerArray.map { type in
                return typeMapping[type] ?? type // 매핑된 값이 없는 경우 원래 값 그대로 반환
            }
        }
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
                self?.WildPokemonPower = data
            })
            .store(in: &cancellables)
    }
    
    func fetchPokemonGenera(id: Int) {
        let url = URL.urlWithsepc(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.Pokemongenera = data
            })
            .store(in: &cancellables)
    }
    
    func fetchPokemonWeight(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonWeight = data
            })
            .store(in: &cancellables)
    }
    
    func fetchPokemonHeight(id: Int) {
        let url = URL.urlWith(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonHeight = data
            })
            .store(in: &cancellables)
    }
    
    func fetchPokemonText(id: Int) {
        let url = URL.urlWithsepc(id: id)
        guard let url = url else { return }

        Pokemon.getData(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during fetchMainPokemon: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.PokemonText = data
            })
            .store(in: &cancellables)
    }
}
