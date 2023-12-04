//
//  LoginVC.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/29.
//

import UIKit

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var kakaoAuth: KakaoAuth = { KakaoAuth() }()
    @IBAction func KakaoLoginBtn(_ sender: Any) {
        kakaoAuth.handleKakaoLogin{success in
            if success {
                let controller = UIAlertController(title: nil, message: "Enter E-mail", preferredStyle: .alert)
                controller.addTextField{ field in
                }
                let okAction = UIAlertAction(title: "OK", style: .default) { action in
                    if let TextField = controller.textFields {
                        UserDefaults.standard.set(TextField, forKey: "UserEmailKey")
                        
                    } else {
                        print("카카오 로그인 실패.")
                    }
                }
                
            }
        }
    }
}
