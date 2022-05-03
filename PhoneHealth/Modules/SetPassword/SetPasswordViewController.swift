//
//  SetPasswordViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import Alamofire

class SetPasswordViewController: UIViewController, Storyboarded {

//    @IBOutlet weak var confirmShowHide: UIButton!
    @IBOutlet weak var showHideBtn: UIButton!
    @IBOutlet weak var passwordsValidationContainer: UIView!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var passwordField: MDCOutlinedTextField!
    @IBOutlet weak var confirmPassword: MDCOutlinedTextField!
    
    var passwordHidden = true
//    var confirmHidden = true
    var viewModel: SetPasswordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHideBtn.setTitle("", for: .normal)
//        confirmShowHide.setTitle("", for: .normal)
        self.proceedBtn.isEnabled = false
        passwordsValidationContainer.layer.borderWidth = 1
        passwordsValidationContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        passwordsValidationContainer.addCornerRadius(12)
        proceedBtn.addCornerRadius(12)
        passwordField.setup("Password")
        confirmPassword.setup("Confirm Password")
        passwordField.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        passwordField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        confirmPassword.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        proceedBtn.addTarget(self, action: #selector(actionProceed), for: .touchUpInside)
        
        self.viewModel.status.bind { status in
            self.proceedBtn.isEnabled = (status?.0 ?? false) && self.passwordField.text == self.confirmPassword.text
            if status?.0 == true {
                self.passwordField.leadingAssistiveLabel.text = ""
            } else {
                self.passwordField.leadingAssistiveLabel.text = status?.1
            }
        }
        
        self.viewModel.confirmStatus.bind { status in
            self.proceedBtn.isEnabled = status?.0 ?? false && self.passwordField.leadingAssistiveLabel.text == ""
            if status?.0 == true {
                self.confirmPassword.leadingAssistiveLabel.text = ""
            } else {
                self.confirmPassword.leadingAssistiveLabel.text = status?.1
            }
        }
        
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
        
        self.viewModel.setPasswordModel.bind { model in
            UserDefaults.standard.set(model?.token, forKey: "AT")
            UserDefaults.standard.set(model?.username, forKey: "mobile")
            guard let navigationController = self.navigationController else {return}
            let coodinator = UpdateProfileCoordinator.init(navigationController: navigationController, user: nil)
            coodinator.start()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Set Password"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    @IBAction func showHide(_ sender: UIButton) {
        
        passwordHidden = !passwordHidden
        self.passwordField.isSecureTextEntry = passwordHidden
        self.confirmPassword.isSecureTextEntry = passwordHidden
        
    }
//
//    @IBAction func showCOnfirmPass(_ sender: Any) {
//        confirmHidden = !confirmHidden
//        self.confirmPassword.isSecureTextEntry = confirmHidden
//    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        switch sender {
        case passwordField:
            self.viewModel.password = passwordField.text
        case confirmPassword:
            self.viewModel.confirm = confirmPassword.text
        default:
            break
        }
    }
    
    @objc func actionProceed() {
        self.viewModel.setPassword(password: self.viewModel.password ?? "")
    }
    

}
