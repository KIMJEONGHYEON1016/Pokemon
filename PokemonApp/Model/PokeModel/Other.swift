
import Foundation

struct Other: Codable {

  var dreamWorld      : DreamWorld?      = DreamWorld()
  var home            : Home?            = Home()
  var officialArtwork : OfficialArtwork? = OfficialArtwork()

  enum CodingKeys: String, CodingKey {

    case dreamWorld      = "dream_world"
    case home            = "home"
    case officialArtwork = "official_artwork"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    dreamWorld      = try values.decodeIfPresent(DreamWorld.self      , forKey: .dreamWorld      )
    home            = try values.decodeIfPresent(Home.self            , forKey: .home            )
    officialArtwork = try values.decodeIfPresent(OfficialArtwork.self , forKey: .officialArtwork )
 
  }

  init() {

  }

}