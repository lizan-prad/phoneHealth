//
//  LoginViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MBRadioCheckboxButton
import WeScan

class LoginViewController: UIViewController, Storyboarded, CheckboxButtonDelegate {
    
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
       
    }
    

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var MobileNumber: MDCOutlinedTextField!
    @IBOutlet weak var Password: MDCOutlinedTextField!
    @IBOutlet weak var checkBox: CheckboxButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var signUpbtn: UIButton!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MobileNumber.setup("Mobile Number")
        signInBtn.isEnabled = false
        Password.setup("Password")
        checkBox.setTitle("", for: .normal)
        signInBtn.addCornerRadius(12)
        MobileNumber.keyboardType = .namePhonePad
        checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        checkBox.delegate = self
        
        signInBtn.addTarget(self, action: #selector(proceedSignIn), for: .touchUpInside)
        signUpbtn.addTarget(self, action: #selector(proceedSignUp), for: .touchUpInside)
        
        viewModel.loginModel.bind { model in
            UserDefaults.standard.set(model?.token, forKey: "AT")
            UserDefaults.standard.set(model?.username, forKey: "Mobile")
           
            let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
            appdelegate.window?.rootViewController = vc
        }
        
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error) { _ in}
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
        
        MobileNumber.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        Password.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        signInBtn.isEnabled = (MobileNumber.text != "" && Password.text != "")
        switch sender {
        case MobileNumber:
            MobileNumber.leadingAssistiveLabel.text = (MobileNumber.text == "") ? "Please enter mobile number" : ""
            
        case Password:
            Password.leadingAssistiveLabel.text = (Password.text == "") ? "Please enter password" : ""
        default:
            break
        }
    }
    
    @objc func proceedSignUp() {
        guard let navigationController = self.navigationController else {return}
        let coodinator = RegistrationCoordinator.init(navigationController: navigationController)
        coodinator.start()
    }
    
    @objc func proceedSignIn() {
        self.viewModel.login(MobileNumber.text ?? "", loginPassword: Password.text ?? "")
    }
}

