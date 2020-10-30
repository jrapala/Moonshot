//
//  Mission.swift
//  Moonshot
//
//  Created by Juliette Rapala on 10/29/20.
//

// Create a nested struct.
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}

