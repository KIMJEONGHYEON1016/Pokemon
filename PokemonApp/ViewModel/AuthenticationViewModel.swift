//
//  AuthenticationViewModel.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/04.
//

import Foundation
import UIKit
import Combine

class AuthenticationViewModel {
    private var google: GoogleAuthentication
    private var cancellables = Set<AnyCancellable>()

    var GoogleUserData: PassthroughSubject<AppUser, Never> = PassthroughSubject<AppUser, Never>()

    init(_ google: GoogleAuthentication) {
        self.google = google
    }

    func initializeGoogleLogin(_ vc: UIViewController) {
        google.signIn(vc)
            .sink(receiveCompletion: { completion in
                // 에러 처리 로직
            }, receiveValue: { [weak self] userData in
                self?.GoogleUserData.send(userData)
            })
            .store(in: &cancellables)
    }
}
