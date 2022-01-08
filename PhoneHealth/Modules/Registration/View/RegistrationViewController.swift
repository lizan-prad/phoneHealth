//
//  RegistrationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 06/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class RegistrationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var mobileNumberField: MDCOutlinedTextField!
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var FullNameField: MDCOutlinedTextField!
    @IBOutlet weak var signUpBtn: UIButton!
    var viewModel: RegistrationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumberField.setup("Mobile Number")
        FullNameField.setup("Full Name")
        signUpBtn.addCornerRadius(12)
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(didTapCheckBox)))
        // Do any additional setup after loading the view.
    }
  
    @objc func didTapCheckBox() {
        
    }

}

extension MDCOutlinedTextField {
    func setup(_ placeholder: String) {
        self.setOutlineColor(UIColor.lightGray, for: MDCTextControlState.normal)
        self.setOutlineColor(UIColor.init(hex: "46C9BD"), for: MDCTextControlState.editing)
        self.label.text = placeholder
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
