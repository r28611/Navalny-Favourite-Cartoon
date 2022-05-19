//
//  CharactersViewController.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 25/04/2022.
//

import UIKit
import Combine

class CharactersViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var inputTextFiel: UISearchBar!
    @IBOutlet var imageView: UIImageView!
    
    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: CharacterViewModel?
    let timerNumber = Timer
        .publish(every: 3.0, on: .main, in: .common)
        .autoconnect()
        .scan(0) { counter, _ in counter + 1 }
    // TODO: stop it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputNumber = inputTextFiel.searchTextField.publisher(for: \.text)
            .compactMap { $0.flatMap(Int.init) }
            .merge(with: timerNumber)
            .eraseToAnyPublisher()
        
        viewModel = CharacterViewModel(inputIdentifiersPublisher: inputNumber)
        
        viewModel?.character
            .receive(on: DispatchQueue.main)
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
