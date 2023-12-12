
import Foundation

struct GenerationIii: Codable {

  var emerald          : Emerald?          = Emerald()
  var fireredLeafgreen : FireredLeafgreen? = FireredLeafgreen()
  var rubySapphire     : RubySapphire?     = RubySapphire()

  enum CodingKeys: String, CodingKey {

    case emerald          = "emerald"
    case fireredLeafgreen = "firered_leafgreen"
    case rubySapphire     = "ruby_sapphire"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    emerald          = try values.decodeIfPresent(Emerald.self          , forKey: .emerald          )
    fireredLeafgreen = try values.decodeIfPresent(FireredLeafgreen.self , forKey: .fireredLeafgreen )
    rubySapphire     = try values.decodeIfPresent(RubySapphire.self     , forKey: .rubySapphire     )
 
  }

  init() {

  }

}