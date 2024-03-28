//
//  Heroes.swift
//  SwiftBootcampUIKit
//
//  Created by Jose Luis Escolá García on 7/3/24.
//

import Foundation

struct HeroeDTO: Codable {
    let id: UUID
    let nombreReal: String
    let apodo: String
    let descripcion: String?
    let edad: Int
    let poderes: [String]
    let imagen: String?
    
    enum CodingKeys: CodingKey {
        case id
        case nombreReal
        case apodo
        case descripcion
        case edad
        case poderes
        case imagen
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<HeroeDTO.CodingKeys> = try decoder.container(keyedBy: HeroeDTO.CodingKeys.self)
        
        // Custom id decode
        let idString = try container.decode(String.self, forKey: .id)
        let uuid = UUID(uuidString: idString) ?? UUID()
            self.id = uuid
        
        self.nombreReal = try container.decode(String.self, forKey: HeroeDTO.CodingKeys.nombreReal)
        self.apodo = try container.decode(String.self, forKey: HeroeDTO.CodingKeys.apodo)
        self.descripcion = try container.decodeIfPresent(String.self, forKey: HeroeDTO.CodingKeys.descripcion)
        self.edad = try container.decode(Int.self, forKey: HeroeDTO.CodingKeys.edad)
        self.poderes = try container.decode([String].self, forKey: HeroeDTO.CodingKeys.poderes)
        self.imagen = try container.decodeIfPresent(String.self, forKey: HeroeDTO.CodingKeys.imagen)
        
    }
}
