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

     func character(id: Int) -> AnyPublisher<Character, NetworkError> {
         return URLSession.shared
             .dataTaskPublisher(for: Method.character(id).url) .receive(on: queue)
             .map(\.data)
             .decode(type: Character.self, decoder: decoder)
             .mapError {
                 $0 is URLError
                 ? NetworkError.unreachableAddress(url: Method.character(id).url)
                 : NetworkError.invalidResponse
             }
             .eraseToAnyPublisher()
     }

     func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, NetworkError> {
         precondition(!ids.isEmpty)

         let initialPublisher = character(id: ids[0])
         let remainder = Array(ids.dropFirst())

         return remainder.reduce(initialPublisher) { (combined, id) in
             return combined
                 .merge(with: character(id: id))
                 .eraseToAnyPublisher()
         }
     }
    
    func Locations() -> AnyPublisher<[LocationData], NetworkError> {
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
