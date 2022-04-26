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
    @IBOutlet var imageView: UIImageView!
    
    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ViewModel?
    let timerNumber = Timer
        .publish(every: 3.0, on: .main, in: .common)
        .autoconnect()
        .scan(0) { counter, _ in counter + 1 }
        .eraseToAnyPublisher()
    // TODO: stop it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputNumber = inputTextFiel.publisher(for: \.text).compactMap { $0.flatMap(Int.init) }.eraseToAnyPublisher()
        
        viewModel = ViewModel(apiClient: APIClient(),
                              inputIdentifiersPublisher: timerNumber)
        
        viewModel?.character
            .map { $0 }
            .catch { _ in Empty<Character, Never>()}
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { [weak self] character in
                self?.imageView.downloaded(from: character.image)
                self?.textLabel.text = character.description
            })
            .store(in: &subscriptions)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resign))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func resign() {
        view.endEditing(true)
        resignFirstResponder()
    }
}
