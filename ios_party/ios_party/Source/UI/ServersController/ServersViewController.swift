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

class ServersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoryboardLoadable {
    
    private var serversArray = [ServersModel]()
    var eventHandler: ((ServersEvent) -> ())?
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet var rootView: ServersView?
    
    static func startVC() -> ServersViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getServers()
        self.setTableVievDelegate()
        self.rootView?.setNavigationBar()
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
    
    func getServers() {
        
        guard let url = URL(string: AppURL.serversUrl) else { return }
        let header: HTTPHeaders = [Headers.authorization : Headers.bearer]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [ServersModel].self) { response in
                switch response.result {
                case .success(let servers):
                    self.serversArray = servers
                    self.rootView?.tableView.reloadData()
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            print(error.errorDescription)
                        }
                    }
                }
        }
    }
}
