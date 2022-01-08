//
//  SetPasswordViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SetPasswordViewController: UIViewController {

    @IBOutlet weak var passwordsValidationContainer: UIView!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var passwordField: MDCOutlinedTextField!
    @IBOutlet weak var confirmPassword: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordsValidationContainer.layer.borderWidth = 1
        passwordsValidationContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        passwordsValidationContainer.addCornerRadius(12)
        proceedBtn.addCornerRadius(12)
        passwordField.setup("Password")
        confirmPassword.setup("Confirm Password")
        passwordField.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        
    }
    

}
