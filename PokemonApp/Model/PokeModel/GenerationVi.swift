
import Foundation

struct GenerationVi: Codable {

  var omegarubyAlphasapphire : OmegarubyAlphasapphire? = OmegarubyAlphasapphire()
  var xY                     : XY?                     = XY()

  enum CodingKeys: String, CodingKey {

    case omegarubyAlphasapphire = "omegaruby_alphasapphire"
    case xY                     = "x_y"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    omegarubyAlphasapphire = try values.decodeIfPresent(OmegarubyAlphasapphire.self , forKey: .omegarubyAlphasapphire )
    xY                     = try values.decodeIfPresent(XY.self                     , forKey: .xY                     )
 
  }

  init() {

  }

}