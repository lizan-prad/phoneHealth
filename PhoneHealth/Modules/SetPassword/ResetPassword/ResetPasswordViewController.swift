//
//  ResetPasswordViewController.swift
//  PhoneHealth
//
//  Created by Macbook Pro on 23/05/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var mobileField: MDCOutlinedTextField!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var smoke: UIView!
    
    var didSelectMobile: ((String) -> ())?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        container.addCornerRadius(12)
        mobileField.delegate = self
        mobileField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        smoke.isUserInteractionEnabled = true
        smoke.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(close)))
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let MAX_LENGTH = 10
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        resetBtn.isEnabled = (mobileField.text?.count ?? 0) == 10
        
        mobileField.leadingAssistiveLabel.text = ((mobileField.text?.count ?? 0) < 10) ? "Mobile number must be 10 digit" : ""
        
        
    }
    
    func setup() {
        resetBtn.addCornerRadius(12)
        mobileField.setup("Mobile Number")
    }
    
    @IBAction func resetAction(_ sender: Any) {
        didSelectMobile?(mobileField.text ?? "")
        UserDefaults.standard.set(mobileField.text ?? "", forKey: "Mobile")
        self.dismiss(animated: true)
    }
    

}
