//
//  PokemonCollectionView.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/13.
//

import Foundation
import UIKit
import Combine
import SDWebImage

class PokemonCollectionView: UIViewController {
    
    @IBOutlet weak var pokemonCollection: UICollectionView!
    
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCollection.dataSource = self
        pokemonCollection.delegate = self
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
    }
    
   

}


//데이터 소스 설정
extension PokemonCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 151
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cellId = String(describing: PokemonCollectionViewCell.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PokemonCollectionViewCell


        // 각 셀에 대해 이미지 설정
        let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(indexPath.row + 1).png"
                guard let imageUrl = URL(string: imageUrlString) else {
                    return cell
                }

                // SDWebImage를 사용하여 이미지 설정
        cell.PokemonImage.sd_setImage(with: imageUrl, completed: nil)
        
        cell.PokemonName.text = PokemonViewModel.allPokemonNames[indexPath.row]
        cell.PokemonImage.layer.cornerRadius = 10
        return cell
    }
}

//액션과 관련됨
extension PokemonCollectionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    }
}


