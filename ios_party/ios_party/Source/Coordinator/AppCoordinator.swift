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
        self.createAuthController()
    }
    
    private func createAuthController() {
        let controller = AuthViewController.startVC()
        
        self.authController = controller
        self.navigationController.pushViewController(controller, animated: true)
        
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
    //неработает
    func backToAuthController() {
        let controller = ServersViewController.startVC()
        self.serversController = controller
        self.navigationController.pushViewController(controller, animated: true)
        
        controller.eventHandler = { [weak self] event in
            switch event {
            case .backToAuth:
                self?.createAuth()
                self?.serversController = nil
            case .logout:
               print("jj")
            }
            
        }
    }
    
    private func createServersViewController() {
        
        let controller = ServersViewController.startVC()
        self.navigationController.pushViewController(controller, animated: true)
        
    }
    //не работает
    private func createAuth() {
        let controller = AuthViewController.startVC()
        self.navigationController.pushViewController(controller, animated: true)
        print("createAuth")
    }
    
    private func showAlertError(with message: String) {
        self.navigationController.showAlert(title: message)
    }
}
