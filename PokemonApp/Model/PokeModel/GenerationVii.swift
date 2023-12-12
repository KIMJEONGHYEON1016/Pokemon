
import Foundation

struct GenerationVii: Codable {

  var icons             : Icons?             = Icons()
  var ultraSunUltraMoon : UltraSunUltraMoon? = UltraSunUltraMoon()

  enum CodingKeys: String, CodingKey {

    case icons             = "icons"
    case ultraSunUltraMoon = "ultra_sun_ultra_moon"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    icons             = try values.decodeIfPresent(Icons.self             , forKey: .icons             )
    ultraSunUltraMoon = try values.decodeIfPresent(UltraSunUltraMoon.self , forKey: .ultraSunUltraMoon )
 
  }

  init() {

  }

}