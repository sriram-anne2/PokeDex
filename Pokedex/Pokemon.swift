//
//  Pokemon.swift
//  Pokedex
//
//  Created by Anne, Sriram on 5/8/20.
//  Copyright © 2020 CS50. All rights reserved.
//

import Foundation


// Codable means serialization => converting to and fro JSON objects to Swift Objects


struct PokemonList: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
//    let number: Int
    let url: String
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonData: Codable {
    let id: Int
    let types: [PokemonTypeEntry]
}
