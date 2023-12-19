//
//  MyPokemonList.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/18.
//

import Foundation
import UIKit

class MyPokemonColletionView: UIViewController {
    
    @IBOutlet weak var myPokemonColltion: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonColltion.dataSource = self
        myPokemonColltion.delegate = self
    }
}

extension MyPokemonColletionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: MyPokemonColletionView.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyPokemonCollectionViewCell
        
        
        return cell
    }
}

//액션과 관련됨
extension MyPokemonColletionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

