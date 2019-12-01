//
//  LoadingViewCellControllerTableViewCell.swift
//  ios_party
//
//  Created by Юлия Воротченко on 06.11.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class ServersCell: UITableViewCell {
    
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.serverLabel.text = ""
        self.distanceLabel.text = ""
    }
    
    public func fill(with model: ServersModel) {
        self.serverLabel.text = model.name
        self.distanceLabel.text = "\(model.distance)" + " " + Constants.km
    }
}
