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
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var rootView: ServersView?
    var eventHandler: ((ServersEvent) -> ())?
    
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
    
    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serversArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath) as? ServersCell else { return UITableViewCell() }
        let server = serversArray[indexPath.row]
        
        cell.fill(with: server)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(serversArray[indexPath.row])
       
        self.eventHandler?(.showItem(serversArray[indexPath.row]))
        
    }
    
    private func setTableVievDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - IBActions
   
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
        showAlert(title: nil, message: nil, preferredStyle: .actionSheet, actions: [byDistanceAction, alpfaNumericalAction, cancelAction])
        
    }
    
    func alphanumericalSort() {
        serversArray.sort(by: { $0.name < $1.name })
        tableView.reloadData()
    }
    
    func distanceSort() {
        serversArray.sort(by: { $0.distance < $1.distance })
        tableView.reloadData()
    }
    
    //MARK: Get request

    func getServers() {
       
        let url = URL(string: AppURL.getServers)!
        let header: HTTPHeaders = [Headers.authorization : Headers.bearer]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [ServersModel].self) { response in
                switch response.result {
                case .success(let servers):
                    self.serversArray = servers
                    self.tableView.reloadData()
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
