
import Foundation

struct Emerald: Codable {

  var frontDefault : String? = nil
  var frontShiny   : String? = nil

  enum CodingKeys: String, CodingKey {

    case frontDefault = "front_default"
    case frontShiny   = "front_shiny"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    frontDefault = try values.decodeIfPresent(String.self , forKey: .frontDefault )
    frontShiny   = try values.decodeIfPresent(String.self , forKey: .frontShiny   )
 
  }

  init() {

  }

}