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
        self.getToken()
    }
    
    func getToken() {
        guard
            let username = rootView?.userNameTextField?.text,
            let password = rootView?.passwordTextField?.text,
            let url = URL(string: "http://playground.tesonet.lt/v1/tokens")
            else { return }
        
        let model = UserModel(username: username, password: password)
        let parameters: [String: Any] = ["username": model.username, "password": model.password]
        let header: HTTPHeaders = ["Content-Type": "application/json; charset=UTF-8"]
        self.showSpinner()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: TokenModel.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let token):
                    UserDefaultsContainer.sessionToken = token.token
                    self.eventHandler?(.login)
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            let message = NetworkErrorModel(message: error.errorDescription!)
                            self.eventHandler?(.error(message.message))
                        }
                    }
                    self.hideSpinner()
                }
        }
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
        self.showSpinner()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: TokenModel.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let token):
                    UserDefaultsContainer.sessionToken = token.token
                    self.eventHandler?(.login)
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            let message = NetworkErrorModel(message: error.errorDescription!)
                            self.eventHandler?(.error(message.message))
                        }
                    }
                    self.hideSpinner()
                }
                
        }
        
    }
    
    
    
    
}
