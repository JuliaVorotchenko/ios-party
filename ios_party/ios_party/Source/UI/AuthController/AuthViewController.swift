//
//  AuthViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit
import Alamofire

enum AuthEvent {
    case login
    case error(String)
}

class AuthViewController: UIViewController, StoryboardLoadable, UITextFieldDelegate {
    
    @IBOutlet var rootView: AuthView?
    
    
    var eventHandler: ((AuthEvent) -> ())?
    
    static func startVC() -> AuthViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegateSet()
    }
    
    
    
    @IBAction func onLogin(_ sender: UIButton) {
        //self.getToken()
        self.getTokenAlamof()
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
        self.showSpinner()
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
                            self?.hideSpinner()
                            print("Token:", tokenModel)
                        } catch {
                            self?.eventHandler?(.error(error.localizedDescription))
                            print(error)
                            self?.hideSpinner()
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
                            print(error)
                        }
                        self?.hideSpinner()
                        
                    }
                }
            }
            
            
        }
        task.resume()
    }
    
    
    //MARK: - to hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: - texfielddelegate
    
    func textFieldDelegateSet() {
        self.rootView?.userNameTextField?.delegate = self
        self.rootView?.passwordTextField?.delegate = self
    }
    
    
    
    
    
    
    func getTokenAlamof() {
        guard
            let username = rootView?.userNameTextField?.text,
            let password = rootView?.passwordTextField?.text,
            let url = URL(string: "http://playground.tesonet.lt/v1/tokens")
            else { return }
        
        
        let model = UserModel(username: username, password: password)
        let parameters: [String: Any] = ["username": model.username, "password": model.password]
        let header: HTTPHeaders = ["Content-Type": "application/json; charset=UTF-8"]
        
        
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseDecodable(of: TokenModel.self) { response in
            print(response.debugDescription)
            switch response.result {
            case .success(let token):
                print(token, "token hey")
                UserDefaultsContainer.sessionToken = token.token
                
            case .failure(let error):
                
                print(error, "error")
            }
            
        }
        
        
        
        
        //        let request = session.request(url, method: .post, parameters: model, encoder: JSONParameterEncoder.default, headers: header)
//        
//    
//        
//        request.responseDecodable(of: TokenModel.self) { response in
//            switch response.result {
//            case let .success(result):
//                print(result.token)
//                
//            case let .failure(error):
//                print(error, "error")
//            }
//        }
    }
    
    
    
    
}
