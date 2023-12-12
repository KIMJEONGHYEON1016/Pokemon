
import Foundation

struct GameIndices: Codable {

  var gameIndex : Int?     = nil
  var version   : Version? = Version()

  enum CodingKeys: String, CodingKey {

    case gameIndex = "game_index"
    case version   = "version"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    gameIndex = try values.decodeIfPresent(Int.self     , forKey: .gameIndex )
    version   = try values.decodeIfPresent(Version.self , forKey: .version   )
 
  }

  init() {

  }

}