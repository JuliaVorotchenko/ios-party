//
//  AppCoordinator.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

  class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    var authController: AuthViewController?
    var serversController: ServersViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if UserDefaultsContainer.sessionToken.isEmpty {
            self.createAuthController()
        } else {
            self.createServersViewController()
        }
       
        
    }
    
    private func createAuthController() {
        let controller = AuthViewController.startVC()
        
        self.authController = controller
        self.navigationController.viewControllers = [controller]
        
        controller.eventHandler = { [weak self] event in
            switch event {
            case .login:
               
                self?.createServersViewController()
                 self?.authController = nil
            case .error(let errorMessage):
                self?.showAlertError(with: errorMessage)
            }
        }
    }
    
    
    private func createServersViewController() {
        
        let controller = ServersViewController.startVC()
        self.navigationController.viewControllers = [controller]
        controller.eventHandler = { [weak self] event in
             switch event {
             
             case .logout:
                UserDefaultsContainer.unregister()
                self?.createAuthController()
               
             }
             
         }
    }
   
    
    private func showAlertError(with message: String) {
        self.navigationController.showAlert(title: message)
    }
}
