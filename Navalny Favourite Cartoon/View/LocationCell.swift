//
//  LocationCell.swift
//  Navalny Favourite Cartoon
//
//  Created by Margarita Novokhatskaia on 07/05/2022.
//

import UIKit

class LocationCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    var locationModel: LocationData? {
        didSet {
            setup()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setup() {
        self.nameLabel.text = locationModel?.name
        self.typeLabel.text = locationModel?.type
    }
}
