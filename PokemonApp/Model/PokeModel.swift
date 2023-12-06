//
//  PokeService.swift
//  PokemonApp
//
//  Created by 김정현 on 2023/12/06.
//

import Foundation

struct Pokemon: Codable {

  var height                 : Int?           = nil
  var heldItems              : [String]?      = []
  var id                     : Int?           = nil
  var name                   : String?        = nil
  var sprites                : Sprites?       = Sprites()
  var stats                  : [Stats]?       = []
  var types                  : [Types]?       = []
  var weight                 : Int?           = nil

  enum CodingKeys: String, CodingKey {


    case height                 = "height"
    case id                     = "id"
    case name                   = "name"
    case sprites                = "sprites"
    case stats                  = "stats"
    case types                  = "types"
    case weight                 = "weight"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    height                 = try values.decodeIfPresent(Int.self           , forKey: .height                 )
    id                     = try values.decodeIfPresent(Int.self           , forKey: .id                     )
    name                   = try values.decodeIfPresent(String.self        , forKey: .name                   )

    sprites                = try values.decodeIfPresent(Sprites.self       , forKey: .sprites                )
    stats                  = try values.decodeIfPresent([Stats].self       , forKey: .stats                  )
    types                  = try values.decodeIfPresent([Types].self       , forKey: .types                  )
    weight                 = try values.decodeIfPresent(Int.self           , forKey: .weight                 )
 
  }

  init() {

  }

}


struct Official_artwork: Codable {

  var frontDefault : String? = nil
  var frontShiny   : String? = nil

  enum CodingKeys: String, CodingKey {

    case frontDefault = "front_default"
    case frontShiny   = "front_shiny"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    frontDefault = try values.decodeIfPresent(String.self , forKey: .frontDefault )
    frontShiny   = try values.decodeIfPresent(String.self , forKey: .frontShiny   )
 
  }

  init() {

  }

}

struct DreamWorld: Codable {

  var frontDefault : String? = nil
  var frontFemale  : String? = nil

  enum CodingKeys: String, CodingKey {

    case frontDefault = "front_default"
    case frontFemale  = "front_female"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    frontDefault = try values.decodeIfPresent(String.self , forKey: .frontDefault )
    frontFemale  = try values.decodeIfPresent(String.self , forKey: .frontFemale  )
 
  }

  init() {

  }

}

struct Home: Codable {

  var frontDefault     : String? = nil
  var frontFemale      : String? = nil
  var frontShiny       : String? = nil
  var frontShinyFemale : String? = nil

  enum CodingKeys: String, CodingKey {

    case frontDefault     = "front_default"
    case frontFemale      = "front_female"
    case frontShiny       = "front_shiny"
    case frontShinyFemale = "front_shiny_female"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    frontDefault     = try values.decodeIfPresent(String.self , forKey: .frontDefault     )
    frontFemale      = try values.decodeIfPresent(String.self , forKey: .frontFemale      )
    frontShiny       = try values.decodeIfPresent(String.self , forKey: .frontShiny       )
    frontShinyFemale = try values.decodeIfPresent(String.self , forKey: .frontShinyFemale )
 
  }

  init() {

  }

}

struct Other: Codable {

  var dreamWorld       : DreamWorld?       = DreamWorld()
  var home             : Home?             = Home()
  var official_artwork : Official_artwork? = Official_artwork()

  enum CodingKeys: String, CodingKey {

    case dreamWorld       = "dream_world"
    case home             = "home"
    case official_artwork = "official_artwork"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    dreamWorld       = try values.decodeIfPresent(DreamWorld.self       , forKey: .dreamWorld       )
    home             = try values.decodeIfPresent(Home.self             , forKey: .home             )
    official_artwork = try values.decodeIfPresent(Official_artwork.self , forKey: .official_artwork )
 
  }

  init() {

  }

}

struct Sprites: Codable {

  var backDefault      : String?   = nil
  var backFemale       : String?   = nil
  var backShiny        : String?   = nil
  var backShinyFemale  : String?   = nil
  var frontDefault     : String?   = nil
  var frontFemale      : String?   = nil
  var frontShiny       : String?   = nil
  var frontShinyFemale : String?   = nil
  var other            : Other?    = Other()

  enum CodingKeys: String, CodingKey {

    case backDefault      = "back_default"
    case backFemale       = "back_female"
    case backShiny        = "back_shiny"
    case backShinyFemale  = "back_shiny_female"
    case frontDefault     = "front_default"
    case frontFemale      = "front_female"
    case frontShiny       = "front_shiny"
    case frontShinyFemale = "front_shiny_female"
    case other            = "other"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    backDefault      = try values.decodeIfPresent(String.self   , forKey: .backDefault      )
    backFemale       = try values.decodeIfPresent(String.self   , forKey: .backFemale       )
    backShiny        = try values.decodeIfPresent(String.self   , forKey: .backShiny        )
    backShinyFemale  = try values.decodeIfPresent(String.self   , forKey: .backShinyFemale  )
    frontDefault     = try values.decodeIfPresent(String.self   , forKey: .frontDefault     )
    frontFemale      = try values.decodeIfPresent(String.self   , forKey: .frontFemale      )
    frontShiny       = try values.decodeIfPresent(String.self   , forKey: .frontShiny       )
    frontShinyFemale = try values.decodeIfPresent(String.self   , forKey: .frontShinyFemale )
    other            = try values.decodeIfPresent(Other.self    , forKey: .other            )
 
  }

  init() {

  }

}

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


struct Type: Codable {

  var name : String? = nil
  var url  : String? = nil

  enum CodingKeys: String, CodingKey {

    case name = "name"
    case url  = "url"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name = try values.decodeIfPresent(String.self , forKey: .name )
    url  = try values.decodeIfPresent(String.self , forKey: .url  )
 
  }

  init() {

  }

}

struct Types: Codable {

  var slot : Int?  = nil
  var type : Type? = Type()

  enum CodingKeys: String, CodingKey {

    case slot = "slot"
    case type = "type"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    slot = try values.decodeIfPresent(Int.self  , forKey: .slot )
    type = try values.decodeIfPresent(Type.self , forKey: .type )
 
  }

  init() {

  }

}

struct Stat: Codable {

  var name : String? = nil
  var url  : String? = nil

  enum CodingKeys: String, CodingKey {

    case name = "name"
    case url  = "url"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name = try values.decodeIfPresent(String.self , forKey: .name )
    url  = try values.decodeIfPresent(String.self , forKey: .url  )
 
  }

  init() {

  }

}


