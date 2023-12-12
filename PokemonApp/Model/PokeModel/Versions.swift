
import Foundation

struct Versions: Codable {

  var generationI    : GenerationI?    = GenerationI()
  var generationIi   : GenerationIi?   = GenerationIi()
  var generationIii  : GenerationIii?  = GenerationIii()
  var generationIv   : GenerationIv?   = GenerationIv()
  var generationV    : GenerationV?    = GenerationV()
  var generationVi   : GenerationVi?   = GenerationVi()
  var generationVii  : GenerationVii?  = GenerationVii()
  var generationViii : GenerationViii? = GenerationViii()

  enum CodingKeys: String, CodingKey {

    case generationI    = "generation-i"
    case generationIi   = "generation-ii"
    case generationIii  = "generation-iii"
    case generationIv   = "generation-iv"
    case generationV    = "generation-v"
    case generationVi   = "generation-vi"
    case generationVii  = "generation-vii"
    case generationViii = "generation-viii"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    generationI    = try values.decodeIfPresent(GenerationI.self    , forKey: .generationI    )
    generationIi   = try values.decodeIfPresent(GenerationIi.self   , forKey: .generationIi   )
    generationIii  = try values.decodeIfPresent(GenerationIii.self  , forKey: .generationIii  )
    generationIv   = try values.decodeIfPresent(GenerationIv.self   , forKey: .generationIv   )
    generationV    = try values.decodeIfPresent(GenerationV.self    , forKey: .generationV    )
    generationVi   = try values.decodeIfPresent(GenerationVi.self   , forKey: .generationVi   )
    generationVii  = try values.decodeIfPresent(GenerationVii.self  , forKey: .generationVii  )
    generationViii = try values.decodeIfPresent(GenerationViii.self , forKey: .generationViii )
 
  }

  init() {

  }

}
