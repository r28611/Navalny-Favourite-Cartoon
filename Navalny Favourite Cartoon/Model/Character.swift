//
//  Character.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import Foundation

public struct Character: Codable, CustomStringConvertible {
    public var description: String {
"""
        Name: \(name)
        Status: \(status)
        Species: \(species)
        Type: \(type)
        Gender: \(gender)
        Origin: \(origin.name)
"""
    }
    
    public var id: Int64
    public var name: String
    public var status: String
    public var species: String
    public var type: String
    public var gender: String
    public var image: String
    public var origin: Location
    public init(id: Int64, name: String, status: String, species: String, type: String, gender: String, image: String, origin: Location) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.origin = origin
    }
    
}
public struct Location: Codable {
        let name: String
}
