
import Foundation

struct PokemonData: Codable {

  var abilities              : [Abilities]?   = []
  var baseExperience         : Int?           = nil
  var forms                  : [Forms]?       = []
  var gameIndices            : [GameIndices]? = []
  var height                 : Int?           = nil
  var heldItems              : [String]?      = []
  var id                     : Int?           = nil
  var isDefault              : Bool?          = nil
  var locationAreaEncounters : String?        = nil
  var moves                  : [Moves]?       = []
  var name                   : String?        = nil
  var order                  : Int?           = nil
  var pastAbilities          : [String]?      = []
  var pastTypes              : [String]?      = []
  var species                : Species?       = Species()
  var sprites                : Sprites?       = Sprites()
  var stats                  : [Stats]?       = []
  var types                  : [Types]?       = []
  var weight                 : Int?           = nil

  enum CodingKeys: String, CodingKey {

    case abilities              = "abilities"
    case baseExperience         = "base_experience"
    case forms                  = "forms"
    case gameIndices            = "game_indices"
    case height                 = "height"
    case heldItems              = "held_items"
    case id                     = "id"
    case isDefault              = "is_default"
    case locationAreaEncounters = "location_area_encounters"
    case moves                  = "moves"
    case name                   = "name"
    case order                  = "order"
    case pastAbilities          = "past_abilities"
    case pastTypes              = "past_types"
    case species                = "species"
    case sprites                = "sprites"
    case stats                  = "stats"
    case types                  = "types"
    case weight                 = "weight"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    abilities              = try values.decodeIfPresent([Abilities].self   , forKey: .abilities              )
    baseExperience         = try values.decodeIfPresent(Int.self           , forKey: .baseExperience         )
    forms                  = try values.decodeIfPresent([Forms].self       , forKey: .forms                  )
    gameIndices            = try values.decodeIfPresent([GameIndices].self , forKey: .gameIndices            )
    height                 = try values.decodeIfPresent(Int.self           , forKey: .height                 )
    heldItems              = try values.decodeIfPresent([String].self      , forKey: .heldItems              )
    id                     = try values.decodeIfPresent(Int.self           , forKey: .id                     )
    isDefault              = try values.decodeIfPresent(Bool.self          , forKey: .isDefault              )
    locationAreaEncounters = try values.decodeIfPresent(String.self        , forKey: .locationAreaEncounters )
    moves                  = try values.decodeIfPresent([Moves].self       , forKey: .moves                  )
    name                   = try values.decodeIfPresent(String.self        , forKey: .name                   )
    order                  = try values.decodeIfPresent(Int.self           , forKey: .order                  )
    pastAbilities          = try values.decodeIfPresent([String].self      , forKey: .pastAbilities          )
    pastTypes              = try values.decodeIfPresent([String].self      , forKey: .pastTypes              )
    species                = try values.decodeIfPresent(Species.self       , forKey: .species                )
    sprites                = try values.decodeIfPresent(Sprites.self       , forKey: .sprites                )
    stats                  = try values.decodeIfPresent([Stats].self       , forKey: .stats                  )
    types                  = try values.decodeIfPresent([Types].self       , forKey: .types                  )
    weight                 = try values.decodeIfPresent(Int.self           , forKey: .weight                 )
 
  }

  init() {

  }

}