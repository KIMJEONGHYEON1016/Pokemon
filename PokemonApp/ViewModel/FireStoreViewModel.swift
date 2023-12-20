//
//  FireStoreViewModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/19.
//

import Foundation
import Combine
import FirebaseFirestore

class FireStoreViewModel {
    private var FireStore: FireStoreService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var pokemonID: FireStoreModel?

    
    init(_ FireStore: FireStoreService) {
        self.FireStore = FireStore
        self.pokemonID = FireStoreModel(pokeNumber: []) // 초기화하여 nil이 아닌 값으로 설정
    }
    
    
    //포획한 포켓몬을 파이어베이스에 저장하기 위한 로직
    func addNewPokemonNumber(email: String, newPokeNumber: Int) {
            // FirebaseService를 통해 데이터 추가
        FireStore.addPokemonNumber(email: email, newPokeNumber: newPokeNumber)
        }
    
    
    
    //포켓몬 미니 이미지를 가져오기 위한 파이어베이스 로직
    func getPokemonData(for email: String) {
        FireStore.getPokemonData(for: email)
                .sink { completion in
                    // 데이터를 가져오는 데에 실패한 경우 처리
                    switch completion {
                        case .failure(let error):
                            print("데이터 가져오기 실패: \(error.localizedDescription)")
                        case .finished:
                            break
                    }
                } receiveValue: { pokeNumbers in
                    // 가져온 데이터를 처리
                    if let pokeNumbers = pokeNumbers {
                        // 가져온 pokeNumbers 배열을 사용하여 작업 수행
                        self.pokemonID?.pokeNumber = pokeNumbers
                    } else {
                        print("데이터가 존재하지 않음")
                    }
                }
                .store(in: &cancellables) // cancellables에 저장하여 수명주기 관리
        }
}
