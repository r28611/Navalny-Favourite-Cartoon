//
//  ViewController.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var inputTextFiel: UITextField!
    
    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputNumber = inputTextFiel.publisher(for: \.text).compactMap { $0.flatMap(Int.init) }.eraseToAnyPublisher()
        
        viewModel = ViewModel(apiClient: APIClient(),
                              inputIdentifiersPublisher: inputNumber)
        
        viewModel?.character
            .map { $0.description }
            .catch { _ in Empty<String, Never>()}
            .receive(on: RunLoop.main)
            .assign(to: \.text!, on: textLabel)
            .store(in: &subscriptions)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resign))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func resign() {
        view.endEditing(true)
        resignFirstResponder()
    }
}
