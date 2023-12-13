//
//  PokemonCollectionView.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/13.
//

import Foundation
import UIKit
import Combine

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
    
    func PokemonImage(image: UIImageView) {
        pokemonViewModel?.$PokemonData
                    .receive(on: DispatchQueue.main)
                    .sink { data in
                        guard let imageUrlString = data?.sprites?.other?.officialArtwork?.frontDefault,
                              let imageUrl = URL(string: imageUrlString) else { return }
                        
                        print(imageUrl)
                        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                            
                            if let error = error {
                                print("Error fetching image data: \(error)")
                                return
                            }
                            
                            guard let imageData = data else {
                                print("No image data received")
                                return
                            }
                            DispatchQueue.main.async {
                                image.image = UIImage(data: imageData)
                                }
                            }.resume()
                    }.store(in: &cancellables)
    }

}


//데이터 소스 설정
extension PokemonCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cellId = String(describing: PokemonCollectionViewCell.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PokemonCollectionViewCell

        for i in 1...10 {
            pokemonViewModel?.fetchPokemon(id: i)
            PokemonImage(image: cell.PokemonImage)
        }
        return cell
    }
}

//액션과 관련됨
extension PokemonCollectionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var numberOfItemsLoaded = 20
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            // 스크롤이 끝에 도달했을 때 추가 아이템 로드
            numberOfItemsLoaded += 20 // 20개씩 추가로 로드
            pokemonCollection.reloadData() // 셀 재로드
        }
    }
}


