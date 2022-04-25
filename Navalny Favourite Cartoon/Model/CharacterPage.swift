//
//  CharacterPage.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import Foundation

public struct CharacterPage: Codable {
    public var info: PageInfo
    public var results: [Character]
    public init(info: PageInfo, results: [Character]) {
        self.info = info
        self.results = results
    }
}
