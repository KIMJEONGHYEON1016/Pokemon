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
    @IBOutlet weak var BattleStart: UIButton!
    @IBOutlet weak var MainMenu: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var BattleTime: UILabel!
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    private var cancellables = Set<AnyCancellable>()
    var id: Int = Int.random(in: 1...151)
    var partnerPokemonNumber: Int?
    var energy: Int = 0{
        didSet {
            // energy가 변경될 때마다 UIProgressView 업데이트
            updateProgressBar()
        }
    }
    var enemy: Enemy?
    var partner: Partner?
    var timer: Timer?
    var winEnergy: Int = 0
    var secondsPassed = 0{
        didSet {
            BattleTime.text = String(20 - secondsPassed)
        }
    }
    let targetSeconds = 20
    
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
        
        //파트너포켓몬 능력치
        self.pokemonViewModel?.fetchPartnerPokemonPower(id: self.partnerPokemonNumber ?? 0)
        self.PartnerPokemonPower()
        
        
        //야생포켓몬 능력치
        self.pokemonViewModel?.fetchWildPokemonpower(id: self.id)
        self.EnemyPower()
        

    }
    
    @IBAction func BattleStart(_ sender: Any) {
        Battle()
        BattleStart.isHidden = true
    }
    
    //전투 세팅
    func Battle() {
        if let partnerHP = partner?.hp, let enemyHP = enemy?.hp {
            self.energy = (partnerHP + enemyHP) * 10
            self.winEnergy = self.energy * 2
        } else {
            // Handle the case when either partner or enemy or both are nil
            // For example, assigning default values:
            self.energy = 0
            self.winEnergy = 0
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        //타이머 시작
        startTimer()
        startEnergyDecrement()

    }
    
    //공격
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if (partner?.attack)!-(enemy?.defense)!/7 < 1 {
            energy += 1
        } else {
            energy += (partner?.attack)!-((enemy?.defense)! + (enemy?.hp)!)/7
            print("energy 변수의 값: \(energy)")
    
            if energy >= self.winEnergy {
                self.dismiss(animated: true)
                
                
                timer?.invalidate() // 타이머 중지

                // 타이머가 멈추면서 secondsPassed도 멈추도록 처리
                self.timer = nil // 타이머를 nil로 설정하여 더 이상 업데이트되지 않도록 함
                print("win")
            }
        }
    }
    
    
   // 적 공격
    func startEnergyDecrement() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            // 0.3초마다 energy를 감소시킴
            if (self!.enemy!.attack) - (self!.partner!.defense)/7 < 1 {
                self!.energy -= 1
            }
            self?.energy -= self!.enemy!.attack - ((self!.partner!.defense) + (self!.partner!.hp))/7
            print("energy 변수의 값: \(self?.energy ?? 0)")
            
            // energy가 0 이하로 떨어졌을 때 timer를 중지시킴
            if let energy = self?.energy, energy <= 0 {
                timer.invalidate()
                print("패배")
                self!.timer = nil
                self!.showLossScreen()

            }
        }
    }
    
    //패배화면
    func showLossScreen() {
        let lossView = UIView(frame: UIScreen.main.bounds)
        lossView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        let lossLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        lossLabel.center = lossView.center
        lossLabel.textAlignment = .center
        lossLabel.textColor = UIColor.white
        lossLabel.text = "패배했다. 눈 앞이 깜깜해졌다!"
        lossLabel.numberOfLines = 0
        lossView.addSubview(lossLabel)
        
        if let keyWindowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
            let keyWindow = keyWindowScene.windows.first(where: { $0.isKeyWindow }) {
            
            keyWindow.addSubview(lossView)
            
            // 원하는 시간 이후에 화면을 제거하고 dismiss 실행
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                lossView.removeFromSuperview()
                self.dismiss(animated: true)
            }
        }
    }


    //타이머 시작
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //타이머 관리
    @objc func updateTimer() {
        guard let timer = timer else {
            return // 타이머가 nil이면 함수를 종료
        }
        
        secondsPassed += 1
        // 타이머가 목표 시간에 도달하면 멈추도록 설정
        if secondsPassed >= targetSeconds {
            print("타이머가 \(targetSeconds)초에 도달했습니다.")
            print("Time Over")
            secondsPassed = 0
            self.showLossScreen()
            timer.invalidate() // 타이머 중지

            // 타이머가 멈추면서 secondsPassed도 멈추도록 처리
            self.timer = nil // 타이머를 nil로 설정하여 더 이상 업데이트되지 않도록 함
        } else {
            print("경과 시간: \(secondsPassed)초")
        }
    }




    //프로그래스바 세팅
    func updateProgressBar() {
        if energy != 0 && winEnergy != 0 {
            let progress = Float(energy) / Float(winEnergy)
            let progressBarValue = min(max(progress, 0.0), 1.0) // 0과 1 사이의 값으로 제한
            
            progressView.setProgress(progressBarValue, animated: true) // 진행도 업데이트
        }
    }


   
    
    //야생 포켓몬 능력치
    func EnemyPower(){
        pokemonViewModel?.$WildPokemonPower
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
        timer?.invalidate() // 타이머 중지

        // 타이머가 멈추면서 secondsPassed도 멈추도록 처리
        self.timer = nil // 타이머를 nil로 설정하여 더 이상 업데이트되지 않도록 함
        self.dismiss(animated: true)
    }
    
    
}

