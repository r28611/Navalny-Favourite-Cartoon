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
    case location
    case episode

    var url: URL {
        switch self {
        case .character(let id):
            return Method.baseURL.appendingPathComponent("character/\(id)")
        default:
            // Homework
            fatalError("URL for this case is undefined.")
        }
    }
}
