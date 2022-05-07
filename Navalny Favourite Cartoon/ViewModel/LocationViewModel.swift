//
//  LocationViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 07/05/2022.
//

import Foundation
import Combine

class LocationViewModel {
    internal init(apiClient: APIClient,
                  inputIdentifiersPublisher: AnyPublisher<Int, Never>) {
        self.apiClient = apiClient

        let networking = inputIdentifiersPublisher.map { apiClient.character(id: $0)}.switchToLatest().share()
        self.character = networking.eraseToAnyPublisher()
    }
    
    let apiClient: APIClient
    let character: AnyPublisher<Character, NetworkError>
}
