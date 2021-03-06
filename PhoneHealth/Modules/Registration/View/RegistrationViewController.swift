//
//  RegistrationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 06/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MBRadioCheckboxButton

class RegistrationViewController: UIViewController, Storyboarded, CheckboxButtonDelegate, UITextFieldDelegate {
    
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        signUpBtn.isEnabled = (mobileNumberField.text != "" && FullNameField.text != "") && checkBox.isOn
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        signUpBtn.isEnabled = (mobileNumberField.text != "" && FullNameField.text != "") && checkBox.isOn
    }
    

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var mobileNumberField: MDCOutlinedTextField!
    @IBOutlet weak var checkBox: CheckboxButton!
    @IBOutlet weak var FullNameField: MDCOutlinedTextField!
    @IBOutlet weak var signUpBtn: UIButton!
    var viewModel: RegistrationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        signUpBtn.isEnabled = false
        mobileNumberField.setup("Mobile Number")
        FullNameField.setup("Full Name")
        signUpBtn.addCornerRadius(12)
        checkBox.setTitle("", for: .normal)
        mobileNumberField.keyboardType = .phonePad
        checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        checkBox.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        signUpBtn.addTarget(self, action: #selector(actionSignUp), for: .touchUpInside)
        signInBtn.addTarget(self, action: #selector(actionLogin), for: .touchUpInside)
        FullNameField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        mobileNumberField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        mobileNumberField.delegate = self
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        signUpBtn.isEnabled = (mobileNumberField.text != "" && FullNameField.text != "") && checkBox.isOn
        switch sender {
        case mobileNumberField:
            mobileNumberField.leadingAssistiveLabel.text = ((mobileNumberField.text?.count ?? 0) < 10) ? "Mobile number must be 10 digit" : ""
            
        case FullNameField:
            FullNameField.leadingAssistiveLabel.text = (FullNameField.text == "") ? "Please enter full name" : ""
        default:
            break
        }
    }
    
    fileprivate func bindViewModel() {
        self.viewModel.otpModel.bind({ model in
            guard let model = model else {return}
            UserDefaults.standard.set(self.mobileNumberField.text, forKey: "Mobile")
            UserDefaults.standard.set(self.FullNameField.text, forKey: "FullName")
            self.openOtpView(model: model)
        })
        self.viewModel.error.bind({ error in
            self.mobileNumberField.leadingAssistiveLabel.text = error
//            self.showAlert(title: nil, message: error) { _ in
//
//            }
        })
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    @objc func actionLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionSignUp() {
        self.viewModel.register(self.FullNameField.text ?? "", withMobileNumber: self.mobileNumberField.text ?? "")
    }
    
    fileprivate func openOtpView(model: OtpModel) {
        guard let navigationController = self.navigationController else {return}
        let coordinator = OtpCoordinator.init(navigationController: navigationController, model: model)
        coordinator.start()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let MAX_LENGTH = 10
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
    }

}

extension MDCOutlinedTextField {
    func setup(_ placeholder: String) {
        self.setOutlineColor(UIColor.lightGray, for: MDCTextControlState.normal)
        self.setOutlineColor(UIColor.init(hex: "46C9BD"), for: MDCTextControlState.editing)
        self.label.text = placeholder
        self.containerRadius = 12
        self.setLeadingAssistiveLabelColor(UIColor.red, for: .editing)
        self.setLeadingAssistiveLabelColor(UIColor.red, for: .normal)
        self.font = UIFont.systemFont(ofSize: 13)
        self.setFloatingLabelColor(UIColor.init(hex: "46C9BD"), for: MDCTextControlState.editing)
        self.setNormalLabelColor(UIColor.gray, for: .normal)
    }
}

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func rounded() {
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func addBorder(_ color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
    
    func addBorderwith(_ color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
