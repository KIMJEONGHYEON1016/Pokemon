//
//  ViewController.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/11/28.
//

import UIKit

    class MainView: UIViewController {

        @IBOutlet weak var mainPokemon: UIImageView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            PokeService().getData(url: "https://pokeapi.co/api/v2/pokemon/25/") { [weak self] pokemonSprites in
                       if let urlString = pokemonSprites?.front_default, let imageURL = URL(string: urlString) {
                           // Download the image asynchronously
                           DispatchQueue.global().async {
                               if let imageData = try? Data(contentsOf: imageURL) {
                                   // Update UI on the main queue
                                   DispatchQueue.main.async {
                                       self?.mainPokemon.image = UIImage(data: imageData)
                                   }
                               }
                           }
                       }
                   }
               }


    }

