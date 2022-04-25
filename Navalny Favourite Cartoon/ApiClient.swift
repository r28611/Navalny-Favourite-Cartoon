//
//  ApiClient.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import Foundation
import Combine

struct APIClient {

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

     enum Error: LocalizedError {
         case unreachableAddress(url: URL)
         case invalidResponse

         var errorDescription: String? {
             switch self {
             case .unreachableAddress(let url):
                 return "\(url.absoluteString) is unreachable"
             case .invalidResponse:
                 return "Response with mistake" }
         }
     }

     private let decoder = JSONDecoder()
     private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)

     func character(id: Int) -> AnyPublisher<Character, Error> {
         return URLSession.shared
             .dataTaskPublisher(for: Method.character(id).url) .receive(on: queue)
             .map(\.data)
             .decode(type: Character.self, decoder: decoder)
             .mapError({ error -> Error in switch error {
                 case is URLError:
                 return Error.unreachableAddress(url: Method.character(id).url)
                 default:
                 return Error.invalidResponse }
             })
             .eraseToAnyPublisher()
     }

     func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, Error> {
         precondition(!ids.isEmpty)

         let initialPublisher = character(id: ids[0])
         let remainder = Array(ids.dropFirst())

         return remainder.reduce(initialPublisher) { (combined, id) in
             return combined
                 .merge(with: character(id: id))
                 .eraseToAnyPublisher()
         }
     }
 }
