//
//  LoaderPresenter.swift
//  ios_party
//
//  Created by Юлия Воротченко on 31.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import Foundation
import UIKit

final class LoaderPresenter {
    
    private var loaderWindow: UIWindow? {
        get {
            let loaderWindow = UIWindow(frame: UIScreen.main.bounds)
        loaderWindow.windowLevel = UIWindow.Level.alert + 1
        loaderWindow.rootViewController = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController()
            return loaderWindow
        }
        
        set {
            
        }
    }
    
    func present() {
        loaderWindow?.isHidden = false
        loaderWindow?.makeKeyAndVisible()
        print("loader")
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations:  {
            self.loaderWindow?.alpha = 0.0
            
        }, completion: { _ in
            self.loaderWindow = nil
            print("loader nil")
        })
    }
    
    
}
