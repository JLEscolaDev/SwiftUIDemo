//
//  JSONLoader.swift
//  SwiftBootcampUIKit
//
//  Created by Jose Luis Escolá García on 7/3/24.
//

import Foundation

/// Reusable getJson
protocol JSONLoader {
    static func getJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Codable
}

/// Default json functionality
extension JSONLoader {
    static func getJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Codable {
        let data  = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
}
