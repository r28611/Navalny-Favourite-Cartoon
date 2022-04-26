//
//  ViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation
import Combine

class ViewModel {
    internal init(apiClient: APIClient,
                  inputIdentifiersPublisher: AnyPublisher<Int, Never>) {
        self.apiClient = apiClient
        self.inputIdentifiersPublisher = inputIdentifiersPublisher
    }
    
    let apiClient: APIClient
    let inputIdentifiersPublisher: AnyPublisher<Int, Never>
    
    func fetchCharactersWith(ids: [Int]) -> AnyPublisher<Character, NetworkError> {
        apiClient.mergedCharacters(ids: ids)
    }
}
