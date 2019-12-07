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
    
    private var serversItem: ServersModel?
    var eventHandler:  ((ServerItemEvent) -> ())?
    @IBOutlet var rootView: ServerItemView!
    
    init(with item: ServersModel) {
        self.serversItem = item
        super.init(nibName: "ServerItemViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serversItem.map {
            self.rootView.fill(model: $0)
        }
    }
    
    //MARK: IBAction
    @IBAction func backToServersTapped(_ sender: UIBarButtonItem) {
        self.eventHandler?(.backToServers)
    }
    
}
