//
//  MyPokemonList.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/18.
//

import Foundation
import UIKit
import FirebaseFirestore
import Combine
import SDWebImage

class MyPokemonColletionView: UIViewController {
    
    @IBOutlet weak var myPokemonColltion: UICollectionView!
    var fireStoreViewModel: FireStoreViewModel?
    var fireStore: FireStoreService?
    var cancellables = Set<AnyCancellable>()
    var myPokemonNum: Int = 0
    let userEmail = UserDefaults.standard.string(forKey: "UserEmailKey")!
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonColltion.dataSource = self
        myPokemonColltion.delegate = self
        
        fireStore = FireStoreService()
        fireStoreViewModel = FireStoreViewModel(fireStore!)
    }
    
    func PokemonMiniImage(viewModel: FireStoreViewModel, Num: Int, image: UIImageView) {
        viewModel.$pokemonID
            .receive(on: DispatchQueue.main)
            .sink { data in
                if let pokeNumber = data?.pokeNumber, Num < pokeNumber.count {
                    let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/\(pokeNumber[Num]).png"
                    if let imageUrl = URL(string: imageUrlString) {
                        image.sd_setImage(with: imageUrl, completed: nil)
                        
                        self.myPokemonNum = pokeNumber.count
                        print(imageUrl)
                        print(self.myPokemonNum)
                    }
                }
            }.store(in: &cancellables)
    }


}

extension MyPokemonColletionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPokemonNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: MyPokemonColletionView.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyPokemonCollectionViewCell
        PokemonMiniImage(viewModel: fireStoreViewModel!, Num: indexPath.row, image: cell.pokemon_mini)
            return cell
    }
}

//액션과 관련됨
extension MyPokemonColletionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

