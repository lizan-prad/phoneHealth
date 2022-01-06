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
}
