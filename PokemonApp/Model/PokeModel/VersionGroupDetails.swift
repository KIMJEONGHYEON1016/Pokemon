
import Foundation

struct VersionGroupDetails: Codable {

  var levelLearnedAt  : Int?             = nil
  var moveLearnMethod : MoveLearnMethod? = MoveLearnMethod()
  var versionGroup    : VersionGroup?    = VersionGroup()

  enum CodingKeys: String, CodingKey {

    case levelLearnedAt  = "level_learned_at"
    case moveLearnMethod = "move_learn_method"
    case versionGroup    = "version_group"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    levelLearnedAt  = try values.decodeIfPresent(Int.self             , forKey: .levelLearnedAt  )
    moveLearnMethod = try values.decodeIfPresent(MoveLearnMethod.self , forKey: .moveLearnMethod )
    versionGroup    = try values.decodeIfPresent(VersionGroup.self    , forKey: .versionGroup    )
 
  }

  init() {

  }

}