
import Foundation

struct Crystal: Codable {

  var backDefault           : String? = nil
  var backShiny             : String? = nil
  var backShinyTransparent  : String? = nil
  var backTransparent       : String? = nil
  var frontDefault          : String? = nil
  var frontShiny            : String? = nil
  var frontShinyTransparent : String? = nil
  var frontTransparent      : String? = nil

  enum CodingKeys: String, CodingKey {

    case backDefault           = "back_default"
    case backShiny             = "back_shiny"
    case backShinyTransparent  = "back_shiny_transparent"
    case backTransparent       = "back_transparent"
    case frontDefault          = "front_default"
    case frontShiny            = "front_shiny"
    case frontShinyTransparent = "front_shiny_transparent"
    case frontTransparent      = "front_transparent"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    backDefault           = try values.decodeIfPresent(String.self , forKey: .backDefault           )
    backShiny             = try values.decodeIfPresent(String.self , forKey: .backShiny             )
    backShinyTransparent  = try values.decodeIfPresent(String.self , forKey: .backShinyTransparent  )
    backTransparent       = try values.decodeIfPresent(String.self , forKey: .backTransparent       )
    frontDefault          = try values.decodeIfPresent(String.self , forKey: .frontDefault          )
    frontShiny            = try values.decodeIfPresent(String.self , forKey: .frontShiny            )
    frontShinyTransparent = try values.decodeIfPresent(String.self , forKey: .frontShinyTransparent )
    frontTransparent      = try values.decodeIfPresent(String.self , forKey: .frontTransparent      )
 
  }

  init() {

  }

}