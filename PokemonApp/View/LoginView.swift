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
    
    var googleAuth: GoogleAuthentication?
    var authViewModel: AuthenticationViewModel?
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        googleAuth = GoogleAuthentication()
        authViewModel = AuthenticationViewModel(googleAuth!)
        performAnimationSequence()
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
