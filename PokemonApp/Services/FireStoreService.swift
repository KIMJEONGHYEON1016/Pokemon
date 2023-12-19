//
//  FireStoreService.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/19.
//

import Foundation
import FirebaseFirestore
import Combine

class FireStoreService {
    let db = Firestore.firestore()

    func addPokemonNumber(email: String, newPokeNumber: Int) {
        let docRef = db.collection("포켓몬").document(email)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                // 기존 데이터가 있는 경우
                if var holdingPokemon = document.data()?["보유 포켓몬"] as? [Int] {
                    holdingPokemon.append(newPokeNumber)
                    
                    // 새로운 값이 추가된 배열을 업데이트
                    docRef.updateData(["보유 포켓몬": holdingPokemon]) { error in
                        if let error = error {
                            print("데이터 업데이트 실패: \(error)")
                        } else {
                            print("데이터 업데이트 성공!")
                        }
                    }
                } else {
                    print("기존 '보유 포켓몬' 필드를 찾을 수 없음")
                }
            } else {
                print("문서를 찾을 수 없거나 오류 발생: \(error?.localizedDescription ?? "Unknown error")")
                
                // 새로운 문서와 '보유 포켓몬' 필드를 생성하여 데이터 추가
                let data: [String: Any] = ["보유 포켓몬": [newPokeNumber]]
                docRef.setData(data) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added and updated")
                    }
                }
            }
        }
    }


    func getPokemonData(for email: String) -> AnyPublisher<[Int]?, Error> {
            return Future<[Int]?, Error> { promise in
                let docRef = self.db.collection("포켓몬").document(email)
                docRef.getDocument { document, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let document = document, document.exists {
                        let data = document.data()
                        if let pokeNumber = data?["pokeNumber"] as? [Int] {
                            promise(.success(pokeNumber))
                        } else {
                            promise(.success(nil))
                        }
                    } else {
                        promise(.success(nil))
                    }
                }
            }.eraseToAnyPublisher()
        }
}
