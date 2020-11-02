//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Juliette Rapala on 10/29/20.
//

import Foundation

// extend bundle to give it some additional functionality
extension Bundle {
    // A method generic
    // Generics let us write code that can use a variety of different types.
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        // dateFormat allows us to specify a precise format for our dates
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
