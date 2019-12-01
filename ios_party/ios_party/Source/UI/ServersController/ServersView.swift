//
//  LoadingView.swift
//  ios_party
//
//  Created by Юлия Воротченко on 29.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class ServersView: UIView {
    
    //MARK: - UI elements
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serversNavigationBar: UINavigationBar!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var sortButton: UIButton!
    
   //MARK: Navigation bar buttons setup
    
    func setNavigationBar() {
        self.rightBarButton.image = UIImage(named: "ico-logout")
    }

}
