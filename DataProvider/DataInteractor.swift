//
//  DataInteractor.swift
//  SwiftBootcampUIKit
//
//  Created by Jose Luis Escolá García on 7/3/24.
//

import Foundation

struct HeroeInteractor: DataInteractor, JSONLoader {
    static let shared = HeroeInteractor()
    
    private init() {}
    
    func getHeroes() throws -> [Heroe] {
        guard let url = Bundle.main.url(forResource: "SuperHeroes", withExtension: "json") else { return [] }
        let heroesDTO = try Self.getJSON(url: url, type: [HeroeDTO].self)
        return heroesDTO.map { dto in
            Heroe(
                id: dto.id,
                nombreReal: dto.nombreReal,
                apodo: dto.apodo,
                descripcion: dto.descripcion,
                edad: dto.edad,
                poderes: dto.poderes.compactMap { Poderes(rawValue: $0) },
                imagen: dto.imagen
            )
        }
    }
}

protocol DataInteractor {
    func getHeroes() throws -> [Heroe]
}

