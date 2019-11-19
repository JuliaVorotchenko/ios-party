//
//  ServerItemViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 15.11.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

enum ServerItemEvent {
    case backToServers
}

class ServerItemViewController: UIViewController, StoryboardLoadable {
    
    private var serversItem: ServersModel?
    
    @IBOutlet var serverItemView: ServerItemView!
    var eventHandler:  ((ServerItemEvent) -> ())?
    
    static func startVC(item: ServersModel) -> ServerItemViewController {
        
        let controller = self.loadFromStoryboard()
        controller.serversItem = item
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serversItem.map {
            self.serverItemView.fill(model: $0)
        }
       
    }
    
    //MARK: IBAction
    @IBAction func backToServersTapped(_ sender: UIBarButtonItem) {
        self.eventHandler?(.backToServers)
    }
    
  
    
    
}