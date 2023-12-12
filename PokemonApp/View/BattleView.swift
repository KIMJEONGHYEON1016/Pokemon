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
    
    @IBOutlet weak var WildPokemon: FLAnimatedImageView!
    @IBOutlet weak var PartnerPokemon: FLAnimatedImageView!
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    private var cancellables = Set<AnyCancellable>()
    var id: Int = Int.random(in: 1...151)
    var partnerPokemonNumber: Int?
    var energy: Int = 0
    var enemy: Enemy?
    var partner: Partner?
//    var timer: Timer?
//    let instance = BattleView()
    var winEnergy: Int = 0
//    var secondsPassed = 0
//    let targetSeconds = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = Int.random(in: 1...151)            //랜덤 id
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
//        EnergyBar.trackTintColor = .black

        
        self.pokemonViewModel?.fetchPokemon(id: self.partnerPokemonNumber ?? 0)
        self.PartnerPokemonImage(FLAIMG: self.PartnerPokemon)

        
        
        self.pokemonViewModel?.fetchWildPokemon(id: self.id)
        self.WildPokemonImage(FLAIMG: self.WildPokemon)
        
        //파트너포켓몬 능력치 합산
        self.pokemonViewModel?.fetchPartnerPokemonPower(id: self.partnerPokemonNumber ?? 0)
        self.PartnerPokemonPower()
        
        
        //야생포켓몬 능력치 합산
        self.pokemonViewModel?.fetchPokemon(id: self.id)
        self.EnemyPower()
        
//        self.energy = (Int((partner?.hp)?) + Int((enemy?.hp)?)) * 25
//        self.winEnergy = self.energy * 2
        
//        instance.startEnergyDecrement()     //타이머 시작
//        startTimer()
////        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
    //타이머 함수
//    func startEnergyDecrement() {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] timer in
//            // 0.3초마다 energy를 감소시킴
//            if (self!.enemy?.attack)? - (self!.partner?.defense)? < 1 {
//                self!.energy -= 1
//            }
//            self?.energy -= (self!.enemy?.attack)? - (self!.partner?.defense)?
//            print("Current energy: \(self?.energy ?? 0)")
//            
//            // energy가 0 이하로 떨어졌을 때 timer를 중지시킴
//            if let energy = self?.energy, energy <= 0 {
//                timer.invalidate()
//                print("패배")
//                self?.dismiss(animated: true)
//
//            }
//        }
//    }
//    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//    }
//    
//            @objc func updateTimer() {
//            secondsPassed += 1
//            // 타이머가 목표 시간에 도달하면 멈추도록 설정
//            if secondsPassed >= targetSeconds {
//                timer?.invalidate() // 타이머 중지
//                print("타이머가 \(targetSeconds)초에 도달했습니다.")
//                    print("Time Over")
//                self.dismiss(animated: true)
//                } else {
//                print("경과 시간: \(secondsPassed)초")
//            }
//        }
//

//
//            //공격
//    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
//        if (partner?.attack)!-(enemy?.defense)! < 1 {
//            energy += 1
//        } else {
//            energy += (partner?.attack)!-(enemy?.defense)!
//            print("energy 변수의 값: \(energy)")
//            
//            if energy >= self.winEnergy {
//                self.dismiss(animated: true)
//                print("win")
//            }
//        }
//    }
   
    
    //야생 포켓몬 능력치
    func EnemyPower(){
        pokemonViewModel?.$WildPokemoPower
            .receive(on: DispatchQueue.main)
            .sink { data in
                if let hp = data?.stats?.first?.baseStat,
                   let defense = data?.stats?[1].baseStat,
                   let attack = data?.stats?[2].baseStat {
                    self.enemy = Enemy(hp: hp, defense: defense, attack: attack)
                    print(self.enemy ?? "aa")
                }
            }
            .store(in: &cancellables)
    }
    //아군 포켓몬 능력치
    func PartnerPokemonPower(){
        pokemonViewModel?.$PartnerPokemonPower
            .receive(on: DispatchQueue.main)
            .sink { data in
                if let hp = data?.stats?.first?.baseStat,
                   let defense = data?.stats?[1].baseStat,
                   let attack = data?.stats?[2].baseStat {
                    self.partner = Partner(hp: hp, defense: defense, attack: attack)
                    print(self.partner ?? "a")
                }
            }
            .store(in: &cancellables)
    }

    
    
    func PartnerPokemonImage(FLAIMG: FLAnimatedImageView) {
        pokemonViewModel?.$PokemonData
            .receive(on: DispatchQueue.main)
            .sink { data in
                guard let imageUrlString = data?.sprites?.versions?.generationV?.blackWhite?.animated?.backDefault,
                      let imageUrl = URL(string: imageUrlString) else { return }
                print(imageUrl)
                
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
                             FLAIMG.animatedImage = animatedImage
                        } else {
                            // 만약 FLAnimatedImage 객체를 생성할 수 없는 경우
                            print("Failed to create FLAnimatedImage from data")
                        }
                    }
                }.resume()
            }.store(in: &cancellables)
    }

    
    func WildPokemonImage(FLAIMG: FLAnimatedImageView) {
        pokemonViewModel?.$WildPokemonData
            .receive(on: DispatchQueue.main)
            .sink { data in
                guard let imageUrlString = data?.sprites?.versions?.generationV?.blackWhite?.animated?.frontDefault,
                      let imageUrl = URL(string: imageUrlString) else { return }
                print(imageUrl)
                
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
                             FLAIMG.animatedImage = animatedImage
                        } else {
                            // 만약 FLAnimatedImage 객체를 생성할 수 없는 경우
                            print("Failed to create FLAnimatedImage from data")
                        }
                    }
                }.resume()
            }.store(in: &cancellables)
    }

    @IBAction func MenuBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}

