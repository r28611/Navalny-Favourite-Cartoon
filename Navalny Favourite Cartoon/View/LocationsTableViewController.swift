//
//  LocationsTableViewController.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 28/04/2022.
//

import UIKit
import Combine

private let reuseIdentifier = "Cell"

final class LocationsTableViewController: UITableViewController {
    
    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: LocationViewModel?
    private var locations: [LocationData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LocationViewModel()
        viewModel?.locations
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { [weak self] locations in
                self?.locations = locations })
            .store(in: &subscriptions)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        return cell
    }
}
