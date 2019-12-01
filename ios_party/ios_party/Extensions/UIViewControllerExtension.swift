//
//  UIViewControllerExtension.swift
//  ios_party
//
//  Created by Юлия Воротченко on 28.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//
import UIKit

  fileprivate var activityIndicatorView: UIView?

extension UIViewController {

    struct AppTextConstants {
        static let close = "Close"
        static let serverError = "Server Error"
        static let cancel = "Cancel"
    }
    
    private typealias Text = AppTextConstants
    
    func showAlert(title: String?,
                   message: String? = nil,
                   preferredStyle: UIAlertController.Style = .alert,
                   actions: [UIAlertAction]? = [UIAlertAction(title: Text.close, style: .destructive, handler: nil)]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        actions?.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }

    func showErrorAlert(_ title: String?, error: Error?) {
        self.showAlert(title: title, message: error?.localizedDescription)
    }
    
    func showServerErrorAlert(_ error: Error?) {
        self.showAlert(title: AppTextConstants.serverError, message: error?.localizedDescription)
    }

    func showAlert(title: String? ,
                   message: String?,
                   actionTitle: String?,
                   action: ((UIAlertAction) -> Void)?) {
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: action)
        self.showAlert(title: title, message: message, actions: [alertAction])
    }
    
    func showSpinner() {
        activityIndicatorView = UIView(frame: self.view.bounds)
        activityIndicatorView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = activityIndicatorView!.center
        activityIndicator.startAnimating()
        activityIndicatorView?.addSubview(activityIndicator)
        self.view.addSubview(activityIndicatorView!)
    
    }
    
    func hideSpinner() {
        activityIndicatorView?.removeFromSuperview()
        activityIndicatorView = nil
    }
     
}
