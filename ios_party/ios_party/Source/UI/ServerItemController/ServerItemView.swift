//
//  ServerItemView.swift
//  ios_party
//
//  Created by Юлия Воротченко on 12.11.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class ServerItemView: UIView {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    
    func fill(model: ServersModel) {
        self.name.text = model.name
        self.distance.text = String("\(model.distance)" + " km")
    }
}
