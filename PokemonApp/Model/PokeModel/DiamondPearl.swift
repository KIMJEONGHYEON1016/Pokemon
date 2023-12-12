
import Foundation

struct DiamondPearl: Codable {

  var backDefault      : String? = nil
  var backFemale       : String? = nil
  var backShiny        : String? = nil
  var backShinyFemale  : String? = nil
  var frontDefault     : String? = nil
  var frontFemale      : String? = nil
  var frontShiny       : String? = nil
  var frontShinyFemale : String? = nil

  enum CodingKeys: String, CodingKey {

    case backDefault      = "back_default"
    case backFemale       = "back_female"
    case backShiny        = "back_shiny"
    case backShinyFemale  = "back_shiny_female"
    case frontDefault     = "front_default"
    case frontFemale      = "front_female"
    case frontShiny       = "front_shiny"
    case frontShinyFemale = "front_shiny_female"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    backDefault      = try values.decodeIfPresent(String.self , forKey: .backDefault      )
    backFemale       = try values.decodeIfPresent(String.self , forKey: .backFemale       )
    backShiny        = try values.decodeIfPresent(String.self , forKey: .backShiny        )
    backShinyFemale  = try values.decodeIfPresent(String.self , forKey: .backShinyFemale  )
    frontDefault     = try values.decodeIfPresent(String.self , forKey: .frontDefault     )
    frontFemale      = try values.decodeIfPresent(String.self , forKey: .frontFemale      )
    frontShiny       = try values.decodeIfPresent(String.self , forKey: .frontShiny       )
    frontShinyFemale = try values.decodeIfPresent(String.self , forKey: .frontShinyFemale )
 
  }

  init() {

  }

}