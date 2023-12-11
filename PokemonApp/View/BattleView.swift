//
//  BattleView.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/11.
//

import Foundation
import UIKit
import Combine
import FLAnimatedImage


class BattleView: UIViewController {
    
    @IBOutlet weak var WildPokemon: UIImageView!
    @IBOutlet weak var PartnerPokemon: FLAnimatedImageView!
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    private var cancellables = Set<AnyCancellable>()
    var id = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
        pokemonViewModel?.fetchMainPokemon(id: self.id)       //id에 관한 메서드 변경 예정
        PartnerPokemonImage()
    }
    
    func PartnerPokemonImage() {
        pokemonViewModel?.$PokemonData
            .receive(on: DispatchQueue.main)
            .sink { data in
                guard let imageUrlString = data?.sprites?.versions?.generation_v.black_white,
                      let imageUrl = URL(string: imageUrlString) else { return }
                print(imageUrlString)
                
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Error fetching image data: \(error)")
                        return
                    }
                    
                    guard let imageData = data else {
                        print("No image data received")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let animatedImage = FLAnimatedImage(animatedGIFData: imageData) {
                            self.PartnerPokemon.animatedImage = animatedImage
                        } else {
                            // 만약 FLAnimatedImage 객체를 생성할 수 없는 경우
                            print("Failed to create FLAnimatedImage from data")
                        }
                    }
                }.resume()
            }.store(in: &cancellables)
    }


}

    
