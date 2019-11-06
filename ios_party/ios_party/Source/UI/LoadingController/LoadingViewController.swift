//
//  LoadingViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 29.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoryboardLoadable {
    
    
   @IBOutlet var loadingView: LoadingView?
    
    static func startVC() -> LoadingViewController {
           let controller = self.loadFromStoryboard()
           return controller
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        print("loading vc loaded")
       
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    //MARK: - Table view delegate
    
    //MARK: - Navigation Bar

    private func setNavigationBar() {
        self.loadingView?.leftBarButton.image = UIImage(named: "logo-dark")
        self.loadingView?.rightBarButton.image = UIImage(named: "ico-logout")
    }

}


