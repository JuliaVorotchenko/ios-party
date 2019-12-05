//
//  LoadingViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 29.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit
import Alamofire

enum ServersEvent {
    case logout
    case showItem(ServersModel)
}

class ServersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var serversArray = [ServersModel]()
    private var networking = Networking()
    var eventHandler: ((ServersEvent) -> ())?
    
   
    @IBOutlet var rootView: ServersView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getServersList()
        self.setTableVievDelegate()
        self.rootView?.setNavigationBar()
        self.rootView?.tableView.register(UINib(nibName: "ServersCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Table view data source & delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serversArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath) as? ServersCell else { return UITableViewCell() }
        let server = self.serversArray[indexPath.row]
        
        cell.fill(with: server)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventHandler?(.showItem(serversArray[indexPath.row]))
    }
    
    private func setTableVievDelegate() {
        self.rootView?.tableView.delegate = self
        self.rootView?.tableView.dataSource = self
    }
    
    //MARK: - IBActions & sort
    
    @IBAction func rightBarButtonTapped(_ sender: Any) {
        self.eventHandler?(.logout)
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        let byDistanceAction = UIAlertAction(title: Constants.byDistance, style: .default, handler: { _ in
            self.distanceSort()
        })
        
        let alpfaNumericalAction = UIAlertAction(title: Constants.alphanumerical, style: .default, handler: { _ in
            self.alphanumericalSort()
        })
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil)
        self.showAlert(title: nil, message: nil, preferredStyle: .actionSheet, actions: [byDistanceAction, alpfaNumericalAction, cancelAction])
    }
    
    func alphanumericalSort() {
        self.serversArray.sort(by: { $0.name < $1.name })
        self.rootView?.tableView.reloadData()
    }
    
    func distanceSort() {
        self.serversArray.sort(by: { $0.distance < $1.distance })
        self.rootView?.tableView.reloadData()
    }
    
    //MARK: Get Servers
    
    func getServersList() {
        self.showSpinner()
        self.networking.getServers { [weak self] result in
            switch result {
            case .success(let servers):
                self?.serversArray = servers
                self?.rootView?.tableView.reloadData()
                self?.hideSpinner()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
        
        
    }
}
