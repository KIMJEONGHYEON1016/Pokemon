//
//  ViewController.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/28.
//

import UIKit
import Combine
import SDWebImage

class MainView: UIViewController {
    
    @IBOutlet weak var MainPokemonName: UILabel!
    @IBOutlet weak var MainPokemon: UIImageView!
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    var mainPokemonNumber  = 4
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
        pokemonViewModel?.fetchAllPokemonNames()
        pokemonViewModel?.fetchAllPokemonTypes()
        pokemonViewModel?.fetchPokemon(id: self.mainPokemonNumber)
        pokemonViewModel?.fetchPokemonName(id: self.mainPokemonNumber)
        MoveMainPokemon()
        PokemonName()
        PokemonImage()
        }
    
        
    
    
    
    //관찰 후 메인 포켓몬 이름 변경
    func PokemonName() {
        pokemonViewModel?.$PokemonSpecies
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] data in
                        guard let mainPokemon = data?.names?[2], let nameString = mainPokemon.name else {
                            return
                        }
                        self?.MainPokemonName.text = nameString
                    }
                    .store(in: &cancellables)
    }

    
    //관찰 후 메인 포켓몬 이미지 변경
        func PokemonImage() {
            pokemonViewModel?.$PokemonData
                        .receive(on: DispatchQueue.main)
                        .sink { data in
                            guard let imageUrlString = data?.sprites?.other?.home?.frontDefault,
                                  let imageUrl = URL(string: imageUrlString) else { return }
                            self.MainPokemon.sd_setImage(with: imageUrl, completed: nil)
                        }.store(in: &cancellables)
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

    @IBAction func BattleBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let battleVC = storyboard.instantiateViewController(withIdentifier: "BattleView") as! BattleView
        battleVC.modalPresentationStyle = .fullScreen
        battleVC.partnerPokemonNumber = mainPokemonNumber
        present(battleVC, animated: true)
    }
    
    @IBAction func PokemonCollection(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "PokemonCollectionView") as! PokemonCollectionView
        collectionVC.modalPresentationStyle = .fullScreen
        present(collectionVC, animated: true)
    }
    
}
