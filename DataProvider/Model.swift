//
//  Model.swift
//  PrimeraAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 21/3/24.
//

import Foundation

struct Pokemons: Codable {
    let pokemon: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let type: [String]
    let imageURL: URL
    
    var types: String {
        type.formatted(.list(type: .and))
    }
    
    enum CodingKeys: String, CodingKey {
        case name, type, imageURL
    }
}

func getPokemons() -> [Pokemon] {
    guard let url = Bundle.main.url(forResource: "pokemons", withExtension: "json") else { return [] }
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Pokemons.self, from: data).pokemon
    } catch {
        return []
    }
}

