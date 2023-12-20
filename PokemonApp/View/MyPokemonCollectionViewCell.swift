//
//  MyPokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/19.
//

import UIKit

class MyPokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pokemon_mini: UIImageView!
    override func awakeFromNib() {
           super.awakeFromNib()
           startMovingImageView()
       }
       
    func startMovingImageView() {
        // 타이머를 이용하여 랜덤한 시간 간격으로 이미지뷰의 애니메이션을 선택하여 실행합니다.
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 2.0...3.0), repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            let randomNumber = Int.random(in: 0...1) // 0 또는 1을 랜덤하게 선택
            
            if randomNumber == 0 {
                // 랜덤으로 이미지뷰를 움직이는 애니메이션을 선택하여 실행합니다.
                self.moveRandomly()
            } else {
                // 랜덤으로 이미지뷰를 점프하는 애니메이션을 선택하여 실행합니다.
                self.jump()
            }
        }
    }


    func moveRandomly() {
        let cellSize = self.bounds.size
        let randomX = CGFloat.random(in: 0...(cellSize.width - self.pokemon_mini.bounds.width))
        let randomY = CGFloat.random(in: 0...(cellSize.height - self.pokemon_mini.bounds.height))
        
        UIView.animate(withDuration: 1.0) {
            self.pokemon_mini.frame.origin = CGPoint(x: randomX, y: randomY)
        }
    }

    func jump() {
        let originalY = self.pokemon_mini.frame.origin.y
        let newY = originalY - 15
        
        UIView.animate(withDuration: 0.4, animations: {
            self.pokemon_mini.frame.origin.y = newY
        }) { _ in
            UIView.animate(withDuration: 0.4) {
                self.pokemon_mini.frame.origin.y = originalY
            }
        }
    }

}
