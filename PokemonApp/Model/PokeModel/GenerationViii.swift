
import Foundation

struct GenerationViii: Codable {

  var icons : Icons? = Icons()

  enum CodingKeys: String, CodingKey {

    case icons = "icons"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    icons = try values.decodeIfPresent(Icons.self , forKey: .icons )
 
  }

  init() {

  }

}