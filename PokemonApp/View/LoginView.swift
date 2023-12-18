//
//  LoginVC.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/29.
//

import UIKit
import GoogleSignIn
import Combine

class LoginView: UIViewController {
    
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    
    @IBOutlet weak var MainImage: UIImageView!
    @IBOutlet weak var LoginBtn: UIButton!
    
    var googleAuth: GoogleAuthentication?
    var authViewModel: AuthenticationViewModel?
    private var cancellables = Set<AnyCancellable>()
    var pokemonViewModel: PokemonViewModel?
    var pokeService: PokeService?

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
        googleAuth = GoogleAuthentication()
        authViewModel = AuthenticationViewModel(googleAuth!)
        performAnimationSequence()
        FetchPokemonInfo()
    }
    
    //로그인 전에 포켓몬 배열 저장
    func FetchPokemonInfo(){
        MainImage.isHidden = true
        LoginBtn.isHidden = true
        let loadingImageView = UIImageView(frame: CGRect(x: 160, y: 550, width: 80, height: 65))
        let loadingImageView2 = UIImageView(frame: CGRect(x: 144, y: 253, width: 138, height: 142))

        loadingImageView.image = UIImage(named: "free-icon-loading-8999447")
        loadingImageView2.image = UIImage(named: "free-icon-pikachu-188939")
        self.view.addSubview(loadingImageView)
        self.view.addSubview(loadingImageView2)
        pokemonViewModel?.fetchAllPokemonNames()
        pokemonViewModel?.fetchAllPokemonTypes()
        pokemonViewModel?.$allPokemonTypes
                    .sink { types in
                        if types.count == 151 {
                            DispatchQueue.main.async{
                                loadingImageView.isHidden = true
                                loadingImageView2.isHidden = true
                                self.MainImage.isHidden = false
                                self.LoginBtn.isHidden = false
                                self.LoginBtn.setBackgroundImage(UIImage(named: "google-sign"), for: .normal)
                                self.LoginBtn.contentMode = .scaleToFill
                            }
                        }
                    }.store(in: &cancellables)
    }
    
    //애니메이션 딜레이 함수
    func performAnimationSequence() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.shakeAnimation(imageView: self.Image1) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.shakeAnimation(imageView: self.Image2) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.shakeAnimation(imageView: self.Image3) {
                                // 모든 애니메이션이 끝나면 1초 후에 다시 애니메이션 반복
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.performAnimationSequence()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //이미지 애니메이션 효과
    func shakeAnimation(imageView: UIImageView, completion: @escaping () -> Void) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.3
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: imageView.center.x, y: imageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: imageView.center.x, y: imageView.center.y - 40))
        imageView.layer.add(animation, forKey: "position")
        
        // 애니메이션이 끝나면 completion 블록 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) {
            completion()
        }
    }
    
    //구글 로그인 버튼
    @IBAction func actionButtonGoogle(_ sender: Any) {
        authViewModel?.initializeGoogleLogin(self)
        authViewModel?.GoogleUserData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Publisher가 성공적으로 완료된 경우 (오류가 발생하지 않은 경우)
                    
                    break
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            }, receiveValue: { userData in
                // Publisher로부터 값을 받는 클로저
                UserDefaults.standard.set(userData.email, forKey: "UserEmailKey")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let MainVC = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainVC, animated: false)
        })
            .store(in: &cancellables)
    }

}
