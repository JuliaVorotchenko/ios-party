//
//  AuthViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, StoryboardLoadable {
    
    @IBOutlet var rootView: AuthView?
    
    static func startVC() -> AuthViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLogin(_ sender: UIButton) {
        
    }
    
}
