//
//  CharacterViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation
import Combine

class CharacterViewModel {
    let character: AnyPublisher<Character, NetworkError>

    init(inputIdentifiersPublisher: AnyPublisher<Int, Never>) {
        let apiClient = APIClient()
        
        let timerNumber = Timer
            .publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { counter, _ in counter + 1 }

        self.character = inputIdentifiersPublisher
            .merge(with: timerNumber)
            .map { apiClient.character(id: $0)}
            .switchToLatest()
            .share()
            .eraseToAnyPublisher()
    }
    
}
