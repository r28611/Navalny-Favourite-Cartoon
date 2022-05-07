//
//  LocationData.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 28/04/2022.
//

import Foundation

public struct LocationData: Codable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
}
