//
//  LoadingViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 29.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

enum ServersEvent {
    case backToAuth
    case logout
}

class ServersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoryboardLoadable {
   
   
   @IBOutlet var loadingView: ServersView?
    var eventHandler: ((ServersEvent) -> ())?
    
    static func startVC() -> ServersViewController {
           let controller = self.loadFromStoryboard()
           return controller
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView?.setNavigationBar()
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
    
  
    
    //MARK: - IBActions
    //не работает
    @IBAction func leftBarButtonTapped(_ sender: Any) {
        self.eventHandler?(.backToAuth)
        print("tesonet pressed")
                }
    
    @IBAction func rightBarButtonTapped(_ sender: Any) {
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
    }
    
}


