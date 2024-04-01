//
//  HeroesViewModel.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import Foundation

class HeroesViewModel: ObservableObject, JSONLoader {
    @Published var heroes: [Heroe]

    init() {
        do {
            self.heroes = try Self.getHeroes()
        } catch {
            self.heroes = []
            print("Error tratando de recuperar los héroes del JSON")
        }
    }

    func removeHeroe(at offsets: IndexSet) {
        heroes.remove(atOffsets: offsets)
    }

    func moveHeroe(from source: IndexSet, to destination: Int) {
        heroes.move(fromOffsets: source, toOffset: destination)
    }
    
    static func getHeroes() throws -> [Heroe] {
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
