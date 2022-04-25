//
//  ViewController.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(apiClient: APIClient())
        
        viewModel?.fetchCharactersWith(ids: [123, 77, 9])
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
            .store(in: &subscriptions)}

}

