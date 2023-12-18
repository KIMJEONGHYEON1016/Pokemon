//
//  PokemonType.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/15.
//

import UIKit

enum PokemonType: String {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    
}
let typeMapping: [String: String] = [
    "normal": "노말",
    "fighting": "격투",
    "flying": "비행",
    "poison": "독",
    "ground": "땅",
    "rock": "바위",
    "bug": "벌레",
    "ghost": "유령",
    "steel": "강철",
    "fire": "불",
    "water": "물",
    "grass": "풀",
    "psychic": "에스퍼",
    "ice": "얼음",
    "dragon": "용",
    "dark": "어둠",
    "fairy": "페어리"
]

struct ThemeColor {
    static let primary = UIColor(hexString: "D21312")
    
    static let normal = UIColor(hexString: "D8D9DA")
    static let fighting = UIColor(hexString: "F28705")
    static let flying = UIColor(hexString: "95C8FF")
    static let poison = UIColor(hexString: "9652D9")
    static let ground = UIColor(hexString: "AA7939")
    static let rock = UIColor(hexString: "BCB889")
    static let bug = UIColor(hexString: "9FA423")
    static let ghost = UIColor(hexString: "6E4570")
    static let steel = UIColor(hexString: "6AAED3")
    static let fire = UIColor(hexString: "FF612B")
    static let water = UIColor(hexString: "2892FF")
    static let grass = UIColor(hexString: "47BF26")
    static let electric = UIColor(hexString: "F2CB05")
    static let psychic = UIColor(hexString: "FF637F")
    static let ice = UIColor(hexString: "62DFFF")
    static let dragon = UIColor(hexString: "5462D6")
    static let dark = UIColor(hexString: "4F4747")
    static let fairy = UIColor(hexString: "FFB1FF")
    
    static func typeColor(type: String) -> UIColor {
        switch type {
        case "노말":
            return ThemeColor.normal
        case "격투":
            return ThemeColor.fighting
        case "비행":
            return ThemeColor.flying
        case "독":
            return ThemeColor.poison
        case "땅":
            return ThemeColor.ground
        case "바위":
            return ThemeColor.rock
        case "벌레":
            return ThemeColor.bug
        case "유령":
            return ThemeColor.ghost
        case "강철":
            return ThemeColor.steel
        case "불":
            return ThemeColor.fire
        case "물":
            return ThemeColor.water
        case "풀":
            return ThemeColor.grass
        case "에스퍼":
            return ThemeColor.psychic
        case "얼음":
            return ThemeColor.ice
        case "용":
            return ThemeColor.dragon
        case "어둠":
            return ThemeColor.dark
        case "페어리":
            return ThemeColor.fairy
        default:
            return ThemeColor.fire // 기본값은 불 속성으로 설정합니다.
        }
    }
}
