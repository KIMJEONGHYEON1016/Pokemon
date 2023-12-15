//
//  PokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/13.
//

import UIKit
import Combine

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var PokemonImage: UIImageView!
    @IBOutlet weak var PokemonNumber: UILabel!
    @IBOutlet weak var PokemonName: UILabel!
    @IBOutlet weak var PokemonType1: UILabel!
    @IBOutlet weak var PokemonType2: UILabel!
    var cancellables = Set<AnyCancellable>()
    

    
    override func prepareForReuse() {
        super.prepareForReuse()

            // 셀을 초기화 해주는 코드.
    }
    
}
