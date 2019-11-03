//
//  LoaderViewController.swift
//  ios_party
//
//  Created by Юлия Воротченко on 31.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController, StoryboardLoadable  {

    @IBOutlet weak var loeaderSpinner: UIView!
    let spinnerLayer = CAShapeLayer()
    
    static func startVC() -> LoaderViewController {
        let controller = self.loadFromStoryboard()
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let center = loeaderSpinner.center
               let circularPath = UIBezierPath(arcCenter: center, radius: 73, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi*2, clockwise: true)
               spinnerLayer.path = circularPath.cgPath
               
               spinnerLayer.strokeColor = UIColor.lightGray.cgColor
               
               spinnerLayer.lineWidth = 4
               spinnerLayer.strokeEnd = 0
               spinnerLayer.fillColor = UIColor.clear.cgColor
               
               view.layer.addSublayer(spinnerLayer)
               
               view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        print("attempting to animate stroke")
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        spinnerLayer.add(animation, forKey: "animation")
        
    }

}
