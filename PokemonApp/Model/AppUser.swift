//
//  AppUser.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/04.
//

import Foundation

struct AppUser {
    var token: String
    var name: String
    var email: String
    var userId: String
    var imagePath: URL?
}

protocol SocialAuthenticationDelegate: AnyObject {
    func onAuthenticationSuccess(_ user: AppUser)
    func onAuthenticationError(_ error: Error)
}
