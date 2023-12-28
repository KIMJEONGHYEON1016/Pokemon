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
    @IBOutlet weak var battlePoint: UILabel!
    @IBOutlet weak var pokemonDex: UIButton!
    @IBOutlet weak var myPokemon: UIButton!
    
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    var mainPokemonNumber: Int?
    var partner: Partner?
    var battlepoint: Int = 0
    private var cancellables = Set<AnyCancellable>()
    var fireStoreViewModel: FireStoreViewModel?
    var fireStore: FireStoreService?
    let userEmail = UserDefaults.standard.string(forKey: "UserEmailKey")!
    var isExpanded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDex.isHidden = true
        myPokemon.isHidden = true
        fireStore = FireStoreService()
        fireStoreViewModel = FireStoreViewModel(fireStore!)
        fireStoreViewModel?.getPartnerData(for: self.userEmail)
        fetchPartnerPokemon()
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
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
    
    //파트너 포켓몬 능력치
    func PartnerPokemonPower(){
        pokemonViewModel?.$PartnerPokemonPower
            .sink { data in
                if let hp = data?.stats?.first?.baseStat,
                   let defense = data?.stats?[1].baseStat,
                   let attack = data?.stats?[2].baseStat {
                    self.partner = Partner(hp: hp, defense: defense, attack: attack)
                    self.battlepoint = self.partner!.attack + (self.partner!.defense + self.partner!.hp)/7
                    DispatchQueue.main.async{
                        self.battlePoint.text = String(self.battlepoint * 10)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    //메인 포켓몬 업데이트
    func fetchPartnerPokemon(){
        fireStoreViewModel?.$partnerPokemon
            .receive(on: DispatchQueue.main)
            .sink { [self] data in
                mainPokemonNumber = data
                pokemonViewModel?.fetchPokemon(id: self.mainPokemonNumber!)
                pokemonViewModel?.fetchPokemonName(id: self.mainPokemonNumber!)
                self.pokemonViewModel?.fetchPartnerPokemonPower(id: self.mainPokemonNumber!)
                PokemonImage()
                self.PartnerPokemonPower()
                MoveMainPokemon()
                PokemonName()
                
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
        battleVC.partnerBP = battlePoint.text!
        present(battleVC, animated: true)
    }
    
    @IBAction func PokemonCollection(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionVC = storyboard.instantiateViewController(withIdentifier: "PokemonCollectionView") as! PokemonCollectionView
        collectionVC.modalPresentationStyle = .fullScreen
        present(collectionVC, animated: true)
    }
    
    @IBAction func myPokemon(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MyPokemonColletionVC = storyboard.instantiateViewController(withIdentifier: "MyPokemonColletionView") as! MyPokemonColletionView
        MyPokemonColletionVC.modalPresentationStyle = .fullScreen
        present(MyPokemonColletionVC, animated: true)
    }
    @IBAction func menuBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            if self.pokemonDex.isHidden {
                self.pokemonDex.isHidden = false
                self.myPokemon.isHidden = false
                self.pokemonDex.transform = CGAffineTransform(translationX: 0, y: 40)
                self.myPokemon.transform = CGAffineTransform(translationX: 0, y: 80)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.pokemonDex.transform = .identity
                    self.myPokemon.transform = .identity
                }) { _ in
                    self.pokemonDex.isHidden = true
                    self.myPokemon.isHidden = true
                }
            }
        }
    }

}
