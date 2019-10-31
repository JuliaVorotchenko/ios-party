//
//  LoadingViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 29.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, StoryboardLoadable {
   @IBOutlet var loadingView: LoadingView?
    
    static func startVC() -> LoadingViewController {
           let controller = self.loadFromStoryboard()
           return controller
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loading vc loaded")
       
    }
    
    
    



}
