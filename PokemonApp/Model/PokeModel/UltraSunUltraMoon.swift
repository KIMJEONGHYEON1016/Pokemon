
import Foundation

struct UltraSunUltraMoon: Codable {

  var frontDefault     : String? = nil
  var frontFemale      : String? = nil
  var frontShiny       : String? = nil
  var frontShinyFemale : String? = nil

  enum CodingKeys: String, CodingKey {

    case frontDefault     = "front_default"
    case frontFemale      = "front_female"
    case frontShiny       = "front_shiny"
    case frontShinyFemale = "front_shiny_female"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    frontDefault     = try values.decodeIfPresent(String.self , forKey: .frontDefault     )
    frontFemale      = try values.decodeIfPresent(String.self , forKey: .frontFemale      )
    frontShiny       = try values.decodeIfPresent(String.self , forKey: .frontShiny       )
    frontShinyFemale = try values.decodeIfPresent(String.self , forKey: .frontShinyFemale )
 
  }

  init() {

  }

}