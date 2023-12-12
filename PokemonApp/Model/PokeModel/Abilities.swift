
import Foundation

struct Abilities: Codable {

  var ability  : Ability? = Ability()
  var isHidden : Bool?    = nil
  var slot     : Int?     = nil

  enum CodingKeys: String, CodingKey {

    case ability  = "ability"
    case isHidden = "is_hidden"
    case slot     = "slot"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    ability  = try values.decodeIfPresent(Ability.self , forKey: .ability  )
    isHidden = try values.decodeIfPresent(Bool.self    , forKey: .isHidden )
    slot     = try values.decodeIfPresent(Int.self     , forKey: .slot     )
 
  }

  init() {

  }

}