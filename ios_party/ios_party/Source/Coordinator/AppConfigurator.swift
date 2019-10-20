//
//  AppConfigurator.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

final class AppConfigurator {
    
    private var coordinator: Coordinator?
    
    init(window: UIWindow) {
        self.configure(window: window)
    }
    
    private func configure(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        navigationController.navigationBar.isHidden = true
        self.coordinator = AppCoordinator(navigationController: navigationController)
        self.coordinator?.start()
        window.makeKeyAndVisible()
    }
}
