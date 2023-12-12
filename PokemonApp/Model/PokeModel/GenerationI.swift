
import Foundation

struct GenerationI: Codable {

  var redBlue : RedBlue? = RedBlue()
  var yellow  : Yellow?  = Yellow()

  enum CodingKeys: String, CodingKey {

    case redBlue = "red_blue"
    case yellow  = "yellow"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    redBlue = try values.decodeIfPresent(RedBlue.self , forKey: .redBlue )
    yellow  = try values.decodeIfPresent(Yellow.self  , forKey: .yellow  )
 
  }

  init() {

  }

}