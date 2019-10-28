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
            
            // НАДО для того что бы посмотреть что за ответ я получаю,
            // только тут я сериализовал но по факту это не обязательно
            if let value = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                debugPrint("NetworkParser:", value)
            }
            
            // Диспатч надо что бы вывести на мейн поток.
            DispatchQueue.main.async {
                do {
                    
                    // У нас есть чудесный декодер котоырй умеет декодить то что нам надо
                    // Перегонять в модель что нам нужна
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let tokenModel = try decoder.decode(TokenModel.self, from: data)
                    print(tokenModel)
                } catch {
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
}
