//
//  ViewController.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/28.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var MainPokemonName: UILabel!
    @IBOutlet weak var MainPokemon: UIImageView!
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    var id = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
        pokemonViewModel?.fetchMainPokemon(id: self.id)       //id에 관한 메서드 변경 예정
        pokemonViewModel?.fetchMainPokemonName(id: self.id)
        PokemonImage()
        PokemonName()
        MoveMainPokemon()

        }
        
    
    //관찰 후 메인 포켓몬 이름 변경
    func PokemonName() {
        pokemonViewModel?.PokemonSpecies.bind { data in
            guard let mainPokemon = data.names?[2], let nameString = mainPokemon.name else {
                return
            }
            self.MainPokemonName.text = nameString
        }
    }

    
    //관찰 후 메인 포켓몬 이미지 변경
    func PokemonImage() {
        pokemonViewModel?.PokemonData.bind { data in
            guard let imageUrlString = data.sprites?.other?.home?.front_default else {
                return
            }
            guard let imageUrl = URL(string: imageUrlString) else {
                return
            }
            
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
                    if let image = UIImage(data: imageData) {
                        self.MainPokemon.image = image
                    }
                    
                }
            }.resume()
        }
    }


   
    
    //포켓몬 Move
    func MoveMainPokemon(){
        self.shakeAnimation(imageView: self.MainPokemon) {
            // 모든 애니메이션이 끝나면 1초 후에 다시 애니메이션 반복
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.MoveMainPokemon()
            }
        }
    }
    func shakeAnimation(imageView: UIImageView, completion: @escaping () -> Void) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.2
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: imageView.center.x, y: imageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: imageView.center.x, y: imageView.center.y - 40))
        imageView.layer.add(animation, forKey: "position")
        
        // 애니메이션이 끝나면 completion 블록 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) {
            completion()
        }
    }

}
