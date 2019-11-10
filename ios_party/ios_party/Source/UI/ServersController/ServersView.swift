//
//  LoadingView.swift
//  ios_party
//
//  Created by Юлия Воротченко on 29.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import Foundation
import UIKit

class ServersView: UIView {
    
    //MARK: - UI elements

    @IBOutlet weak var serversNavigationBar: UINavigationBar!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var sortButton: UIButton!
    
   
    //MARK: Navigation bar buttons setup
    func setNavigationBar() {
        self.leftBarButton.image = UIImage(named: "logo-dark")
        self.rightBarButton.image = UIImage(named: "ico-logout")
    }
    
    

    
    
}
