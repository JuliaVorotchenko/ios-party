//
//  AuthViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

enum AuthEvent {
    case login
    case error(String)
}

class AuthViewController: UIViewController, StoryboardLoadable {
    
    @IBOutlet var rootView: AuthView?
   
    
    
    
    var eventHandler: ((AuthEvent) -> ())?
    
    deinit {
        print("authVC")
    }
    
    
    
   
    
    static func startVC() -> AuthViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onLogin(_ sender: UIButton) {
        //self.getToken()
        self.eventHandler?(.login)
    }
    
    func getToken() {
        guard
            let username = rootView?.userNameTextField?.text,
            let password = rootView?.passwordTextField?.text,
            let url = URL(string: "http://playground.tesonet.lt/v1/tokens")
            else { return }
        let model = UserModel(username: username, password: password)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(model)
        
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let tokenModel = try decoder.decode(TokenModel.self, from: data)
                            UserDefaultsContainer.sessionToken = tokenModel.token
                            self?.eventHandler?(.login)
                            print("Token:", tokenModel)
                        } catch {
                            self?.eventHandler?(.error(error.localizedDescription))
                            //self?.showServerErrorAlert(error)
                            print(error)
                        }
                        
                    }
                } else if  httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let errorModel = try decoder.decode(NetworkErrorModel.self, from: data)
                            
                            self?.eventHandler?(.error(errorModel.message))
                            print("error:", errorModel)
                        } catch {
                            self?.eventHandler?(.error(error.localizedDescription))
                            //self?.showServerErrorAlert(error)
                            print(error)
                        }
                        
                    }
                }
            }
            
            
        }
        task.resume()
    }
    
}
