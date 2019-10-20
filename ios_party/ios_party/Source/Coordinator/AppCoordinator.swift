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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.createAuthController()
    }
    
    private func createAuthController() {
        let controller = AuthViewController.startVC()
        self.navigationController.pushViewController(controller, animated: true)
    }
    
}
