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
    var serverItemViewController: ServerItemViewController?
    private let networking = Networking()
    
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
        let controller = AuthViewController(networking: self.networking, event: self.authEvent)
        self.authController = controller
        
        self.navigationController.viewControllers = [controller]

        
    }
    
    private func authEvent(_ event: AuthEvent) {
        
        switch event {
        case .login:
            self.createServersViewController()
            self.authController = nil
        case .error(let errorMessage):
            self.showAlertError(with: errorMessage)
        }
    }
    
    private func createServersViewController() {
        let controller = ServersViewController()
        self.navigationController.viewControllers = [controller]
        controller.eventHandler = { [weak self] event in
            switch event {
            case .logout:
                UserDefaultsContainer.unregister()
                self?.createAuthController()
            case .showItem(let item):
                self?.createServerItemViewController(with: item)
                
            }
            
        }
    }
    
    private func createServerItemViewController(with item: ServersModel) {
        let controller = ServerItemViewController(with: item, eventHandler: self.serverItemEvent)
        
        self.navigationController.pushViewController(controller, animated: true)
    
        
    }
    
    private func serverItemEvent(_ event: ServerItemEvent) {
        switch event {
        case .backToServers:
            self.navigationController.popViewController(animated: true)
        }
    }
    
    private func showAlertError(with message: String) {
        self.navigationController.showAlert(title: message)
    }
}
