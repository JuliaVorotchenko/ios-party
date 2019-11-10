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
        tableView.delegate = self
       tableView.dataSource = self
        self.loadingView?.setNavigationBar()
         
       
       
        print("loading vc loaded")
        print(serversArray.count)
        
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serversArray.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ServersCell
        let server = serversArray[indexPath.row]
        cell.serverLabel.text = server.name
        cell.distanceLabel.text = String(server.distance)
    
        
       
        
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
    
    
    //MARK: Get request
    
    func getServers() {
        let token = UserDefaultsContainer.sessionToken
        
        let url = URL(string: "http://playground.tesonet.lt/v1/servers")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }
            print(data)
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        
                        do {
                            let decoder = JSONDecoder()
                            let servers = try decoder.decode([ServersModel].self, from: data)
                            self.serversArray = servers
                            self.tableView.reloadData()
                        
                            print(self.serversArray)
                        } catch {
                            print(error)
                        }
                    } else if httpResponse.statusCode == 401 {
                        print(error?.localizedDescription)
                    }
                }
                
            }
            
        }
        task.resume()
    }
}
