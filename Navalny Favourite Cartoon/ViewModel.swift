//
//  ViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation
import Combine

class ViewModel {
    internal init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    let apiClient: APIClient
    
    func fetchCharactersWith(ids: [Int]) -> AnyPublisher<Character, NetworkError> {
        apiClient.mergedCharacters(ids: ids)
    }
}
