//
//  LocationViewModel.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 07/05/2022.
//

import Foundation
import Combine

class LocationViewModel {
    @Published var locations: AnyPublisher<[LocationData], NetworkError>
    @Published var error: NetworkError? = nil
    
    init() {
        self.locations = apiClient.locations()
    }
    
    private var apiClient = APIClient()
    private var currentPage: Int = 0
    private var subscriptions: Set<AnyCancellable> = []
}
