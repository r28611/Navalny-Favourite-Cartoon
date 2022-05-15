//
//  Episode.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 28/04/2022.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}
