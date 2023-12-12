
import Foundation

struct GenerationIv: Codable {

  var diamondPearl        : DiamondPearl?        = DiamondPearl()
  var heartgoldSoulsilver : HeartgoldSoulsilver? = HeartgoldSoulsilver()
  var platinum            : Platinum?            = Platinum()

  enum CodingKeys: String, CodingKey {

    case diamondPearl        = "diamond_pearl"
    case heartgoldSoulsilver = "heartgold_soulsilver"
    case platinum            = "platinum"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    diamondPearl        = try values.decodeIfPresent(DiamondPearl.self        , forKey: .diamondPearl        )
    heartgoldSoulsilver = try values.decodeIfPresent(HeartgoldSoulsilver.self , forKey: .heartgoldSoulsilver )
    platinum            = try values.decodeIfPresent(Platinum.self            , forKey: .platinum            )
 
  }

  init() {

  }

}