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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputNumber = inputTextFiel.searchTextField.publisher(for: \.text)
            .compactMap { $0 }
            .eraseToAnyPublisher()
        
        viewModel = CharacterViewModel(inputIdentifiersPublisher: inputNumber)
        
        viewModel?.character
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { [weak self] character in
//                self?.imageView.downloaded(from: character.image)
//                self?.textLabel.text = character.description
                print(character)
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
