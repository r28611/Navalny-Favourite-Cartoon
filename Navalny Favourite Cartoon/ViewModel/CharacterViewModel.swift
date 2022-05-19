//
//  CharacterViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation
import Combine

class CharacterViewModel {
    private let apiClient: APIClient
    let character: AnyPublisher<Character, NetworkError>
    
    init(inputIdentifiersPublisher: AnyPublisher<Int, Never>) {
        let apiClient = APIClient()
        self.apiClient = apiClient
        let networking = inputIdentifiersPublisher.map { apiClient.character(id: $0)}.switchToLatest().share()
        self.character = networking.eraseToAnyPublisher()
    }
    
}
