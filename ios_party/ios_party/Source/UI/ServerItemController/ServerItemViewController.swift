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

final class ServerItemViewController: UIViewController {
    
    private let serversItem: ServersModel
    private let eventHandler:  ((ServerItemEvent) -> ())?
    @IBOutlet var rootView: ServerItemView!
    
    init(with item: ServersModel, eventHandler:  ((ServerItemEvent) -> ())?) {
        self.eventHandler = eventHandler
        self.serversItem = item
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        print(String(describing: type(of: self)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView.fill(model: self.serversItem)
    }
    
    //MARK: IBAction
    @IBAction func backToServersTapped(_ sender: UIBarButtonItem) {
        self.eventHandler?(.backToServers)
    }
    
}
