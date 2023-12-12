
import Foundation

struct Stats: Codable {

  var baseStat : Int?  = nil
  var effort   : Int?  = nil
  var stat     : Stat? = Stat()

  enum CodingKeys: String, CodingKey {

    case baseStat = "base_stat"
    case effort   = "effort"
    case stat     = "stat"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    baseStat = try values.decodeIfPresent(Int.self  , forKey: .baseStat )
    effort   = try values.decodeIfPresent(Int.self  , forKey: .effort   )
    stat     = try values.decodeIfPresent(Stat.self , forKey: .stat     )
 
  }

  init() {

  }

}