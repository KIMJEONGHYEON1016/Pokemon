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
        if PokemonViewModel.allPokemonTypes.count < PokemonViewModel.allPokemonNames.count {
            return PokemonViewModel.allPokemonTypes.count
        } else {
            return PokemonViewModel.allPokemonNames.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: PokemonCollectionViewCell.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PokemonCollectionViewCell
        
        if cell.PokemonType1 != nil && cell.PokemonName != nil && cell.PokemonImage != nil {
            // 각 셀에 대해 이미지 설정
            let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(indexPath.row + 1).png"
            guard let imageUrl = URL(string: imageUrlString) else {
                return cell
            }
            cell.PokemonImage.sd_setImage(with: imageUrl, completed: nil)
            
            
            //포켓몬 이름
            cell.PokemonName.text = PokemonViewModel.allPokemonNames[indexPath.row]
            cell.PokemonImage.layer.cornerRadius = 12
            
           
            //포켓몬 타입
            cell.PokemonType1.layer.cornerRadius = 3
            cell.PokemonType2.layer.cornerRadius = 3
            cell.PokemonType1.clipsToBounds = true
            cell.PokemonType2   .clipsToBounds = true

            if PokemonViewModel.allPokemonTypes[indexPath.row].count == 1  {
                cell.PokemonType2.isHidden = true
                cell.PokemonType1.text = PokemonViewModel.allPokemonTypes[indexPath.row][0]
                
                //타입명 색상
                cell.PokemonType1.backgroundColor = ThemeColor.typeColor(type: cell.PokemonType1.text!)
                
                //이미지 백그라운드 색상
                cell.PokemonImage.backgroundColor = ThemeColor.typeColor(type: cell.PokemonType1.text!).withAlphaComponent(0.6)
            } else if PokemonViewModel.allPokemonTypes[indexPath.row].count == 2  {
    
                cell.PokemonType2.isHidden = false
                cell.PokemonType1.text = PokemonViewModel.allPokemonTypes[indexPath.row][0]
                cell.PokemonType2.text = PokemonViewModel.allPokemonTypes[indexPath.row][1]
                
                //타입명 색상
                cell.PokemonType1.backgroundColor = ThemeColor.typeColor(type: cell.PokemonType1.text!)
                cell.PokemonType2.backgroundColor = ThemeColor.typeColor(type: cell.PokemonType2.text!)
                
                //이미지 백그라운드 색상
                cell.PokemonImage.backgroundColor = ThemeColor.typeColor(type: cell.PokemonType1.text!).withAlphaComponent(0.6)
            } else {
                // 데이터가 로드되지 않은 경우 빈 상태로 표시
                cell.PokemonType1.text = ""
                cell.PokemonType2.text = ""
            }
            
            //도감 번호
            let formattedNumber = String(format: "No.%03d", indexPath.item + 1)
            cell.PokemonNumber.text = formattedNumber
            
            return cell
        } else {
            // 중요한 구성 요소 중 하나라도 nil인 경우에는 셀을 표시하지 않고 빈 셀을 반환
            return UICollectionViewCell()
        }
    }
}

//액션과 관련됨
extension PokemonCollectionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // 스크롤이 끝에 닿았을 때 추가 데이터 로드
        if offsetY > contentHeight - height {
            DispatchQueue.main.async {
                self.pokemonCollection.reloadData()
            }
        }
    }
}


extension PokemonCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 7 // 원하는 간격 설정
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7 // 원하는 간격 설정 (오른쪽과 왼쪽 셀 사이의 간격)
    }
}
