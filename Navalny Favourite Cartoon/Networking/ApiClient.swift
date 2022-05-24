//
//  ApiClient.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import Foundation
import Combine

struct APIClient {

     private let decoder = JSONDecoder()
     private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)

     func character(name: String) -> AnyPublisher<CharacterPage, NetworkError> {
         return URLSession.shared
             .dataTaskPublisher(for: Method.character(name).url) .receive(on: queue)
             .map(\.data)
             .decode(type: CharacterPage.self, decoder: decoder)
             .mapError {
                 $0 is URLError
                 ? NetworkError.unreachableAddress(url: Method.character(name).url)
                 : NetworkError.invalidResponse
             }
             .eraseToAnyPublisher()
     }
    
    func locations() -> AnyPublisher<[LocationData], NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.locations.url) .receive(on: queue)
            .map(\.data)
            .decode(type: LocationPage.self, decoder: decoder)
            .map { $0.results }
            .mapError {
                $0 is URLError
                ? NetworkError.unreachableAddress(url: Method.locations.url)
                : NetworkError.invalidResponse
            }
            .eraseToAnyPublisher()
    }
 }
