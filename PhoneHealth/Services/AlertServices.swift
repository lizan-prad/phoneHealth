//
//  AlertServices.swift
//  VenueFinder
//
//  Created by Lizan on 22/12/2021.
//

import Foundation
import UIKit

class AlertServices {
    typealias CompletionHandler = ((UIAlertAction) -> Void)?
    
    static func showAlertWithOkAction(title: String?, message: String?, completion: CompletionHandler) -> UIAlertController {
        let alertAction = UIAlertAction.init(title: "Ok", style: .default, handler: completion)
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(alertAction)
        return alert
    }
    
    static func showAlertWithOkCancelAction(title: String?, message: String?, okCompletion: CompletionHandler, cancelCompletion: CompletionHandler) -> UIAlertController {
        let alertAction = UIAlertAction.init(title: "Ok", style: .default, handler: okCompletion)
        let cancelAlertAction = UIAlertAction.init(title: "Cancel", style: .destructive, handler: cancelCompletion)
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(alertAction)
        alert.addAction(cancelAlertAction)
        return alert
    }
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?, completion: AlertServices.CompletionHandler) {
        let alert = AlertServices.showAlertWithOkAction(title: title, message: message, completion: completion)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancel(title: String?, message: String?, completion: AlertServices.CompletionHandler, cancel: AlertServices.CompletionHandler ) {
        let alert = AlertServices.showAlertWithOkCancelAction(title: title, message: message, okCompletion: completion, cancelCompletion: cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
