import Foundation
import UIKit
import FirebaseFirestore
import Combine
import SDWebImage

class MyPokemonColletionView: UIViewController {
    
    @IBOutlet weak var myPokemonColltion: UICollectionView!
    @IBOutlet weak var dismissBtn: UIButton!
    var fireStoreViewModel: FireStoreViewModel?
    var fireStore: FireStoreService?
    var cancellables = Set<AnyCancellable>()
    var myPokemonNum: Int = 0
    let userEmail = UserDefaults.standard.string(forKey: "UserEmailKey")!
    var pokeNumber: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonColltion.dataSource = self
        myPokemonColltion.delegate = self
        
        fireStore = FireStoreService()
        fireStoreViewModel = FireStoreViewModel(fireStore!)
        
        
        fireStoreViewModel?.getPokemonData(for: userEmail)
        PokemonMiniImage()
        DismissButton()
    }
    
    func PokemonMiniImage() {
        fireStoreViewModel?.$pokemonID
            .receive(on: DispatchQueue.main)
            .sink { data in
                if let pokeNumber = data?.pokeNumber {
                    self.myPokemonNum = pokeNumber.count
                    self.pokeNumber = pokeNumber
                    self.myPokemonColltion.reloadData()

                        print(self.myPokemonNum)
                    }
            }.store(in: &cancellables)
    }

    @IBAction func DismissButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func DismissButton (){
        dismissBtn.layer.cornerRadius = dismissBtn.frame.height / 2
        dismissBtn.layer.borderWidth = 1.0 // 테두리 두께 설정
        dismissBtn.layer.borderColor = UIColor.systemBlue.cgColor
        dismissBtn.clipsToBounds = true
    }
}

extension MyPokemonColletionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPokemonNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: MyPokemonCollectionViewCell.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyPokemonCollectionViewCell
        
        // 이미지 추가
        let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/icons/\(pokeNumber[indexPath.row]).png"
        if let imageUrl = URL(string: imageUrlString) {
            cell.pokemon_mini.sd_setImage(with: imageUrl, completed: nil)
        }
            return cell
    }
}

//액션과 관련됨
extension MyPokemonColletionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


