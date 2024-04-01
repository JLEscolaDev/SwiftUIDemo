//
//  Heroes.swift
//  SwiftBootcampUIKit
//
//  Created by Jose Luis Escolá García on 7/3/24.
//

import Foundation

struct Heroe: Codable, Identifiable {
    let id: UUID
    let nombreReal: String
    let apodo: String
    let descripcion: String?
    let edad: Int
    let poderes: [Poderes]
    let imagen: String?
}
