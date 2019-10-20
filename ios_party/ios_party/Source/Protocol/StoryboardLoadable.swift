//
//  StoryboardLoadable.swift
//  ios_party
//
//  Created by Юлия Воротченко on 20.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit
protocol StoryboardLoadable {
    static func loadFromStoryboard(storyboardName: String?) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard(storyboardName: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: Self.self), bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self ?? Self()
        
        return controller
    }
}
