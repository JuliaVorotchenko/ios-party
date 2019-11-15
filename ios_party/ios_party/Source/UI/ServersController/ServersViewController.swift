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
}

class ServersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoryboardLoadable {
    
    var serversArray = [ServersModel]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var loadingView: ServersView?
    var eventHandler: ((ServersEvent) -> ())?
    
    static func startVC() -> ServersViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getServers()
        setTableVievDelegate()
        self.loadingView?.setNavigationBar()
        print("loading vc loaded")
        print(serversArray.count)
    }
    
    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serversArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ServersCell
        let server = serversArray[indexPath.row]
        cell.fill(with: server)
        return cell
    }
    
    private func setTableVievDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - IBActions
    //не работает
   
    
    @IBAction func rightBarButtonTapped(_ sender: Any) {
        self.eventHandler?(.logout)
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        let byDistanceAction = UIAlertAction(title: "By Distance", style: .default, handler: { _ in
            self.distanceSort()
        })
        
        let alpfaNumericalAction = UIAlertAction(title: "Alphanumerical", style: .default, handler: { _ in
            self.alphanumericalSort()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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
       
        let token = UserDefaultsContainer.sessionToken
        let url = URL(string: "http://playground.tesonet.lt/v1/servers")!
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [ServersModel].self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let servers):
                    self.serversArray = servers
                    self.tableView.reloadData()
                    print(self.serversArray)
                    
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
