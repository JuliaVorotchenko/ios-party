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
    
    
    private var networking: Networking?
    var eventHandler: ((AuthEvent) -> ())?
    
    @IBOutlet var rootView: AuthView?
    
    static func startVC(networking: Networking) -> AuthViewController {
        let controller = self.loadFromStoryboard()
        controller.networking = networking
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldDelegateSet()
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        self.getToken()
    }
    
    func getToken() {
        guard
            let username = rootView?.userNameTextField?.text,
            let password = rootView?.passwordTextField?.text
            else { return }
        let model = UserModel(username: username, password: password)
        self.showSpinner()
        self.networking?.getToken(model: model) { [weak self] result in
            switch result {
            case .success(let token):
                UserDefaultsContainer.sessionToken = token.token
                self?.eventHandler?(.login)
                self?.hideSpinner()
            case .failure(let error):
                self?.eventHandler?(.error(error.localizedDescription))
                self?.hideSpinner()
            }
        }
    }
    
    //MARK: - to hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: - texfielddelegate
    
    func textFieldDelegateSet() {
        self.rootView?.userNameTextField?.delegate = self
        self.rootView?.passwordTextField?.delegate = self
    }
    
}

