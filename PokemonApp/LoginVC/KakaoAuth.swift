//
//  KakaoAuthVM.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/29.
//

import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuth: ObservableObject {
    typealias KakaoLoginCompletion = (Bool) -> Void
    
    var useremail = ""
    
    func handleKakaoLogin(completion: @escaping KakaoLoginCompletion) {
        print("KakaoAuthVM - handleKakaoLogin() called")
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                    completion(false)
                } else {
                    completion(true)
                    }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                    completion(false)
                } else {
                    print("loginWithKakaoAccount() success.")
                    completion(true)
                }
            }
        }
    }
}
