//
//  Method.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation

enum Method {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!

    case character(Int)
    case locations
    case episode(Int)

    var url: URL {
        switch self {
        case .character(let id):
            return Method.baseURL.appendingPathComponent("character/\(id)")
        case .locations:
            return Method.baseURL.appendingPathComponent("location/")
        case .episode(let id):
            return Method.baseURL.appendingPathComponent("episode/\(id)")
        }
    }
}
