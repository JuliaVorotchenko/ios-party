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
    
    
    public func fill(with model: ServersModel) {
        serverLabel.text = model.name
        distanceLabel.text = "\(model.distance) km"
    }
}
