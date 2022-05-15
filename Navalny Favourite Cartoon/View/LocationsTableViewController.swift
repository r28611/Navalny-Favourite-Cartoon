//
//  LocationsTableViewController.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 28/04/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

final class LocationsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...

        return cell
    }
}
