//
//  AuthViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, StoryboardLoadable {
    
    @IBOutlet var rootView: AuthView?
    
    static func startVC() -> AuthViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLogin(_ sender: UIButton) {
      
getToken()
    }
    
    func getToken() {
        guard
            let username = rootView?.userNameTextField?.text,
            let password = rootView?.passwordTextField?.text,
            let url = URL(string: "http://playground.tesonet.lt/v1/tokens")
            else { return }
        //let model = UserModel(username: "tesonet", password: "partyanimal")
        let model = UserModel(username: username, password: password)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(model)
        
        //Надо для того что бы посмотреть что отправляю на сервак
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else { return }
            }
    
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let tokenModel = try decoder.decode(TokenModel.self, from: data)
                    UserDefaults.standard.set(tokenModel.token, forKey: "Token")
                    print("Token:", tokenModel)
                } catch {
                    self.showServerErrorAlert(error)
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
}
