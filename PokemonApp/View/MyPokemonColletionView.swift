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
    var pokeService: PokeService?
    var pokemonViewModel: PokemonViewModel?
    var cancellables = Set<AnyCancellable>()
    var myPokemonNum: Int = 0
    let userEmail = UserDefaults.standard.string(forKey: "UserEmailKey")!
    var pokeNumber: [Int] = []
    var pokemonTypes : [[String]] = UserDefaults.standard.array(forKey: "allPokemonTypes") as! [[String]]
    var pokemonInfoView: UIView?
    var partnerPokemon: Int?
    var row: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonColltion.dataSource = self
        myPokemonColltion.delegate = self
        
        pokeService = PokeService()
        pokemonViewModel = PokemonViewModel(pokeService!)
        
        fireStore = FireStoreService()
        fireStoreViewModel = FireStoreViewModel(fireStore!)
        
        
        fireStoreViewModel?.getPokemonData(for: userEmail)
        PokemonMiniImage()
        DismissButton()
        addBackgroundTapGesture()
    }
    
    func addBackgroundTapGesture() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
           view.addGestureRecognizer(tapGesture)
       }

    // 배경 터치를 감지하고 뷰를 제거
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        if pokemonInfoView != nil && !pokemonInfoView!.frame.contains(touchPoint) {
            pokemonInfoView?.removeFromSuperview()
        }
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
    
    //포켓몬 분류 가져오기
    func PokemonGenera(label: UILabel) {
        pokemonViewModel?.$Pokemongenera
                    .receive(on: DispatchQueue.main)
                    .sink { data in
                        guard let Pokemongenera = data?.genera?[1], let nameString = Pokemongenera.genus else {
                            return
                        }
                        label.text = nameString
                    }
                    .store(in: &cancellables)
    }
    
    func PokemonHeight(label: UILabel) {
        pokemonViewModel?.$PokemonHeight
                    .receive(on: DispatchQueue.main)
                    .sink { data in
                        guard let PokemonHeight = data?.height else {
                            return
                        }
                        label.text = "       키: " + String(Double(PokemonHeight)/10) + "m"
                    }
                    .store(in: &cancellables)
    }
    
    func PokemonWeight(label: UILabel) {
        pokemonViewModel?.$PokemonWeight
                    .receive(on: DispatchQueue.main)
                    .sink { data in
                        guard let PokemonWeight = data?.weight else {
                            return
                        }
                        label.text = "몸무게: " + String(Double(PokemonWeight)/10) + "kg"
                    }
                    .store(in: &cancellables)
    }
    
    func PokemonText(label: UILabel) {
        pokemonViewModel?.$PokemonText
                    .receive(on: DispatchQueue.main)
                    .sink { data in
                        if data?.flavor_text_entries?[23].language.name == "ko" {
                            guard let PokemonText = data?.flavor_text_entries?[23], let textString = PokemonText.flavor_text else {
                                return
                            }
                            label.text = textString
                        } else {
                            guard let PokemonText = data?.flavor_text_entries?[24], let textString = PokemonText.flavor_text else {
                                return
                            }
                            label.text = textString
                        }
                    }
                    .store(in: &cancellables)
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
           // 원하는 작업 수행
        if pokemonInfoView?.superview == nil {
            pokemonInfoView = UIView(frame: CGRect(x: 16, y: 199, width: 360, height: 450))
            let pokemonImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 190, height: 200))
            pokemonInfoView?.backgroundColor = .white
            pokemonInfoView?.layer.cornerRadius = 15
            pokemonImageView.layer.cornerRadius = 15
            pokemonImageView.clipsToBounds = true
            pokemonInfoView?.layer.borderWidth = 3.0 // 테두리 두께 설정
            pokemonInfoView?.layer.borderColor = UIColor.systemBlue.cgColor // 테두리 색상 설정
            
            
            
            let nameLabel = UILabel(frame: CGRect(x: 220, y: 10, width: 100, height: 50))
            nameLabel.textAlignment = .center
            nameLabel.textColor = UIColor.white
            nameLabel.numberOfLines = 0
            nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
            
            let generaLabel = UILabel(frame: CGRect(x: 198, y: 40, width: 150, height: 50))
            generaLabel.textAlignment = .center
            generaLabel.textColor = UIColor.darkGray
            generaLabel.numberOfLines = 1
            generaLabel.font = UIFont.systemFont(ofSize: 18)
            
            let heightLabel = UILabel(frame: CGRect(x: 201, y: 120, width: 200, height: 50))
            heightLabel.textAlignment = .left
            heightLabel.textColor = UIColor.white
            heightLabel.numberOfLines = 1
            heightLabel.font = UIFont.systemFont(ofSize: 22)
            
            let weightLabel = UILabel(frame: CGRect(x: 198, y: 160, width: 200, height: 50))
            weightLabel.textAlignment = .left
            weightLabel.textColor = UIColor.white
            weightLabel.numberOfLines = 1
            weightLabel.font = UIFont.systemFont(ofSize: 22)
            
            
            let Pokemontext = UILabel(frame: CGRect(x: 24, y: 230, width: 300, height: 150))
            Pokemontext.textAlignment = .left
            Pokemontext.textAlignment = .center
            Pokemontext.textColor = UIColor.white
            Pokemontext.numberOfLines = 0
            Pokemontext.font = UIFont.boldSystemFont(ofSize: 23)
            
            let partnerBtn = UIButton(frame: CGRect(x: 30, y: 370, width: 300, height: 40))
            partnerBtn.layer.cornerRadius = 8
            partnerBtn.clipsToBounds = true
            partnerBtn.backgroundColor = .systemBlue.withAlphaComponent(0.9)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18) // 여기서 16은 원하는 크기로 변경할 수 있습니다.
            ]
            partnerBtn.contentHorizontalAlignment = .center
            let attributedText = NSAttributedString(string: "파트너 포켓몬 지정", attributes: attributes)
            partnerBtn.setTitleColor(.white, for: .normal)
            partnerBtn.setAttributedTitle(attributedText, for: .normal)
            partnerBtn.addTarget(self, action: #selector(partnerButtonTapped), for: .touchUpInside)

            
            let PokemonType1 = UILabel(frame: CGRect(x: 5, y: 205, width: 90, height: 25))
            PokemonType1.textAlignment = .center
            PokemonType1.textColor = UIColor.white
            PokemonType1.numberOfLines = 0
            PokemonType1.font = UIFont.boldSystemFont(ofSize: 18)
            PokemonType1.layer.cornerRadius = 5
            PokemonType1.clipsToBounds = true
            PokemonType1.layer.borderWidth = 1.0 // 테두리 두께 설정
            PokemonType1.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
            
            let PokemonType2 = UILabel(frame: CGRect(x: 100, y: 205, width: 90, height: 25))
            PokemonType2.textAlignment = .center
            PokemonType2.textColor = UIColor.white
            PokemonType2.numberOfLines = 0
            PokemonType2.font = UIFont.boldSystemFont(ofSize: 18)
            PokemonType2.layer.cornerRadius = 5
            PokemonType2.clipsToBounds = true
            PokemonType2.layer.borderWidth = 1.0 // 테두리 두께 설정
            PokemonType2.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
            
            //태그에 indexPath할당 후 포켓몬 이미지 할당
            guard let imageView = sender.view as? UIImageView else { return }
            self.row = imageView.tag // Tag 값을 사용해 IndexPath.row 값을 가져옴
            let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokeNumber[row!]).png"
            //이름 설정
            nameLabel.text = UserDefaults.standard.array(forKey: "allPokemonNames")![pokeNumber[row!]-1] as? String
            if pokemonTypes[pokeNumber[row!]-1].count == 1 {
                PokemonType1.text = pokemonTypes[pokeNumber[row!]-1][0]
                pokemonInfoView?.addSubview(PokemonType1)
            } else {
                PokemonType1.text = pokemonTypes[pokeNumber[row!]-1][0]
                PokemonType2.text = pokemonTypes[pokeNumber[row!]-1][1]
                pokemonInfoView?.addSubview(PokemonType1)
                pokemonInfoView?.addSubview(PokemonType2)
                PokemonType2.backgroundColor = ThemeColor.typeColor(type: PokemonType2.text!)
            }
            PokemonType1.backgroundColor = ThemeColor.typeColor(type: PokemonType1.text!)
            pokemonInfoView?.backgroundColor = ThemeColor.typeColor(type: PokemonType1.text!).withAlphaComponent(0.8)
            
            pokemonViewModel?.fetchPokemonGenera(id: pokeNumber[row!])
            pokemonViewModel?.fetchPokemonWeight(id: pokeNumber[row!])
            pokemonViewModel?.fetchPokemonHeight(id: pokeNumber[row!])
            pokemonViewModel?.fetchPokemonText(id: pokeNumber[row!])
            
            PokemonGenera(label: generaLabel)
            PokemonHeight(label: heightLabel)
            PokemonWeight(label: weightLabel)
            PokemonText(label: Pokemontext)
            
            if let imageUrl = URL(string: imageUrlString) {
                pokemonImageView.sd_setImage(with: imageUrl, completed: nil)  //이미지 설정
            }
            pokemonInfoView?.addSubview(pokemonImageView)
            pokemonInfoView?.addSubview(nameLabel)
            pokemonInfoView?.addSubview(generaLabel)
            pokemonInfoView?.addSubview(heightLabel)
            pokemonInfoView?.addSubview(weightLabel)
            pokemonInfoView?.addSubview(Pokemontext)
            pokemonInfoView?.addSubview(partnerBtn)

            view.addSubview(pokemonInfoView!)
        }
    }
    
    @objc func partnerButtonTapped() {
        partnerPokemon = pokeNumber[row!]
        fireStoreViewModel?.addPartnerPokemon(email: self.userEmail, partnerPokeNumber: partnerPokemon!)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainVC = storyboard.instantiateViewController(withIdentifier: "MainView") as! MainView
        MainVC.mainPokemonNumber = partnerPokemon ?? MainVC.mainPokemonNumber
        print(partnerPokemon!)
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
        
        cell.pokemon_mini.tag = indexPath.row
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        cell.pokemon_mini.isUserInteractionEnabled = true
        cell.pokemon_mini.addGestureRecognizer(tapGesture)
            return cell
    }
}

//액션과 관련됨
extension MyPokemonColletionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


