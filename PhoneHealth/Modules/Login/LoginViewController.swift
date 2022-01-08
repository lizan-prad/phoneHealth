//
//  LoginViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class LoginViewController: UIViewController {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var MobileNumber: MDCOutlinedTextField!
    @IBOutlet weak var Password: MDCOutlinedTextField!
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var signUpbtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MobileNumber.setup("Mobile Number")
        Password.setup("Password")
        signInBtn.addCornerRadius(12)
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(didTapCheckBox)))
    }

    @objc func didTapCheckBox() {
        
    }
}
