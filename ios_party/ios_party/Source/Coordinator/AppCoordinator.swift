//
//  AppCoordinator.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    var authController: AuthViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.createAuthController()
    }
    
    private func createAuthController() {
        let controller = AuthViewController.startVC()
        
        self.authController = controller
        self.navigationController.pushViewController(controller, animated: true)
        
        controller.eventHandler = { [weak self] event in
            switch event {
            case .login:
               
                self?.createLoginController()
                 self?.authController = nil
            case .error(let errorMessage):
                self?.showAlertError(with: errorMessage)
            }
        }
    }
    
    private func createLoginController() {
        
        let controller = ServersViewController.startVC()
        self.navigationController.pushViewController(controller, animated: true)
        
    }
    
    private func showAlertError(with message: String) {
        self.navigationController.showAlert(title: message)
    }
}
