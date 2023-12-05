//
//  LoginVC.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/29.
//

import UIKit
import GoogleSignIn

class LoginView: UIViewController {
    
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    
    var googleAuth: GoogleAuthentication?
    var authViewModel: AuthenticationViewModel?
        
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
        //로그인 기능 구현
        authViewModel?.initializeGoogleLogin(self)
        authViewModel?.GoogleUserData.bind { (userData: AppUser) in
            UserDefaults.standard.set(userData.email, forKey: "UserEmailKey")
            print(UserDefaults.standard.string(forKey: "UserEmailKey") ?? "")
        }
    }
}
