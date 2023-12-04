//
//  GoogleAuthenciation.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/04.
//


import Foundation
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class GoogleAuthentication {
    weak var delegate: SocialAuthenticationDelegate?
    
    func signIn(_ vc: UIViewController, completion: @escaping (Result<AppUser, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] user, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let token = user?.user.accessToken, let idToken = user?.user.idToken else {
                completion(.failure(NSError(domain: "GoogleSignInError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve tokens"])))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: token.tokenString)
            Auth.auth().signIn(with: credential) { (auth, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let authUser = auth?.user {
                        let appUser = AppUser(token: authUser.providerID, name: authUser.displayName ?? "", email: authUser.email ?? "", userId: authUser.uid, imagePath: auth?.user.photoURL)
                        completion(.success(appUser))
                    } else {
                        completion(.failure(NSError(domain: "AuthenticationError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user found after authentication"])))
                    }
                }
            }
        }
    }
}
