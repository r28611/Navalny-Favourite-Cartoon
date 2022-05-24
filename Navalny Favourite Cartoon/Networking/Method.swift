//
//  Method.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation

enum Method {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!

    case character(String)
    case locations
    case episode(Int)

    var url: URL {
        switch self {
        case .character(let name):
            return Method.baseURL.appendingPathComponent("character?name\(name)")
        case .locations:
            return Method.baseURL.appendingPathComponent("location/")
        case .episode(let id):
            return Method.baseURL.appendingPathComponent("episode/\(id)")
        }
    }
}
