//
//  RegistrationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 06/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MBRadioCheckboxButton

class RegistrationViewController: UIViewController, Storyboarded, CheckboxButtonDelegate {
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        
    }
    

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var mobileNumberField: MDCOutlinedTextField!
    @IBOutlet weak var checkBox: CheckboxButton!
    @IBOutlet weak var FullNameField: MDCOutlinedTextField!
    @IBOutlet weak var signUpBtn: UIButton!
    var viewModel: RegistrationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumberField.setup("Mobile Number")
        FullNameField.setup("Full Name")
        signUpBtn.addCornerRadius(12)
        checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        checkBox.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        signUpBtn.addTarget(self, action: #selector(actionSignUp), for: .touchUpInside)
        signInBtn.addTarget(self, action: #selector(actionLogin), for: .touchUpInside)
    }
    
    @objc func actionLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionSignUp() {
        guard let navigationController = self.navigationController else {return}
        let coordinator = OtpCoordinator.init(navigationController: navigationController)
        coordinator.start()
    }
  
    @objc func didTapCheckBox() {
        
    }

}

extension MDCOutlinedTextField {
    func setup(_ placeholder: String) {
        self.setOutlineColor(UIColor.lightGray, for: MDCTextControlState.normal)
        self.setOutlineColor(UIColor.init(hex: "46C9BD"), for: MDCTextControlState.editing)
        self.label.text = placeholder
        self.containerRadius = 12
        self.font = UIFont.systemFont(ofSize: 14)
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
}
