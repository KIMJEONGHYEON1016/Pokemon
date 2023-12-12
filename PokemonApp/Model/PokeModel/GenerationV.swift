
import Foundation

struct GenerationV: Codable {

  var blackWhite : BlackWhite? = BlackWhite()

  enum CodingKeys: String, CodingKey {

    case blackWhite = "black-white"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    blackWhite = try values.decodeIfPresent(BlackWhite.self , forKey: .blackWhite )
 
  }

  init() {

  }

}
