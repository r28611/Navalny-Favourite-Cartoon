//
//  CharacterViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 26/04/2022.
//

import Foundation
import Combine

class CharacterViewModel {
    let character: AnyPublisher<CharacterPage, NetworkError>

    init(inputIdentifiersPublisher: AnyPublisher<String, Never>) {
        let apiClient = APIClient()
        
        let timerNumber = Timer
            .publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { counter, _ in counter + 1 }

        self.character = inputIdentifiersPublisher
//            .merge(with: timerNumber)
//            .throttle(for: .seconds(3.0), scheduler: DispatchQueue.global(), latest: false)
            .map { apiClient.character(name: $0) }
            .switchToLatest()
//            .share()
            .eraseToAnyPublisher()
    }
    
}
