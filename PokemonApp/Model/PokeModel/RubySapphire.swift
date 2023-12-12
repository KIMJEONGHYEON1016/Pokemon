
import Foundation

struct RubySapphire: Codable {

  var backDefault  : String? = nil
  var backShiny    : String? = nil
  var frontDefault : String? = nil
  var frontShiny   : String? = nil

  enum CodingKeys: String, CodingKey {

    case backDefault  = "back_default"
    case backShiny    = "back_shiny"
    case frontDefault = "front_default"
    case frontShiny   = "front_shiny"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    backDefault  = try values.decodeIfPresent(String.self , forKey: .backDefault  )
    backShiny    = try values.decodeIfPresent(String.self , forKey: .backShiny    )
    frontDefault = try values.decodeIfPresent(String.self , forKey: .frontDefault )
    frontShiny   = try values.decodeIfPresent(String.self , forKey: .frontShiny   )
 
  }

  init() {

  }

}