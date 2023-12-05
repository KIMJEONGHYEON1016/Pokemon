//
//  AuthenticationViewModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/04.
//

import Foundation
import UIKit

class AuthenticationViewModel {
    
    private var google: GoogleAuthentication
    var GoogleUserData: Observable<AppUser> = Observable(AppUser(token: "", name: "",
                                                                 email: "", userId: ""))

    var handlerAuthenticationSuccessfull: ((_ user: AppUser) -> Void)?
    var handlerAuthenticationFailure: ((_ error: Error) -> Void)?
    
    init(_ google: GoogleAuthentication) {
        self.google = google
    }
    
    func initializeGoogleLogin(_ vc: UIViewController) {
        google.signIn(vc) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.GoogleUserData.value = userData
            case .failure(let error):
                print("Error during Google sign-in: \(error)")
            }
        }
    }

}

extension AuthenticationViewModel: SocialAuthenticationDelegate {
    func onAuthenticationSuccess(_ user: AppUser) {
        self.handlerAuthenticationSuccessfull?(user)
        self.GoogleUserData.value = user

    }
    
    func onAuthenticationError(_ error: Error) {
        self.handlerAuthenticationFailure?(error)
    }
}


class Observable<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
