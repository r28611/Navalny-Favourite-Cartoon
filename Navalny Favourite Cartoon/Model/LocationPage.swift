//
//  LocationPage.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 24/05/2022.
//

import Foundation

public struct LocationPage: Codable {
    public var info: PageInfo
    public var results: [LocationData]
    public init(info: PageInfo, results: [LocationData]) {
        self.info = info
        self.results = results
    }
}
