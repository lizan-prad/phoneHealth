//
//  UpdateProfileViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class UpdateProfileViewController: UIViewController, Storyboarded {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var uploadImageBtn: UIButton!
    @IBOutlet weak var genderField: MDCOutlinedTextField!
    @IBOutlet weak var adbsField: MDCOutlinedTextField!
    @IBOutlet weak var yearField: MDCOutlinedTextField!
    @IBOutlet weak var monthField: MDCOutlinedTextField!
    @IBOutlet weak var dayFIeld: MDCOutlinedTextField!
    @IBOutlet weak var addressField: MDCOutlinedTextField!
    @IBOutlet weak var emailAddressField: MDCOutlinedTextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var viewModel: UpdateProfileViewModel!
    
    var genders = ["Male", "Female", "Others"]
    var ADBS = ["AD", "BS"]
    let pickerView = UIPickerView()
    let genderPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        pickerView.dataSource = self
        pickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView() {
        dayFIeld.keyboardType = .numberPad
        yearField.keyboardType = .numberPad
        monthField.keyboardType = .numberPad
        self.nextBtn.isEnabled = false
        uploadImageBtn.addCornerRadius(8)
        adbsField.inputView = pickerView
        genderField.inputView = genderPickerView
        nextBtn.addCornerRadius(12)
        profileImage.addCornerRadius(profileImage.frame.height/2)
        uploadImageBtn.addCornerRadius(8)
        genderField.setup("Gender")
        adbsField.setup("AD/BS")
        yearField.setup("Year")
        monthField.setup("Month")
        dayFIeld.setup("Day")
        addressField.setup("Address")
        emailAddressField.setup("Email Address")
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        
        dayFIeld.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        monthField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        yearField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        addressField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        emailAddressField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        nextBtn.isEnabled = validateForm()
        switch sender {
        case dayFIeld:
            dayFIeld.setOutlineColor(dayFIeld.text == "" ? .red : .lightGray, for: .normal)
            dayFIeld.setOutlineColor(dayFIeld.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case monthField:
            monthField.setOutlineColor(monthField.text == "" ? .red : .lightGray, for: .normal)
            monthField.setOutlineColor(monthField.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case yearField:
            yearField.setOutlineColor(yearField.text == "" ? .red : .lightGray, for: .normal)
            yearField.setOutlineColor(yearField.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case addressField:
            addressField.leadingAssistiveLabel.text = addressField.text == "" ? "Enter your address" : ""
        case emailAddressField:
            emailAddressField.leadingAssistiveLabel.text = emailAddressField.text == "" ? "Enter your email address" : ""
        default:
            break
        }
    }
    
    func validateForm() -> Bool {
        adbsField.setOutlineColor(adbsField.text == "" ? .red : .lightGray, for: .normal)
        genderField.leadingAssistiveLabel.text = genderField.text == "" ? "Select Gender" : ""
        return (genderField.text != "" && adbsField.text != "" && dayFIeld.text != "" && monthField.text != "" && yearField.text != "" && addressField.text != "" && emailAddressField.text != "")
    }
    
    @objc func actionNext() {
        guard let navigationController = self.navigationController else {return}
        let coodinator = UserSteppingCoordinator.init(navigationController: navigationController)
        coodinator.start()
    }

}


extension UpdateProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case genderPickerView:
            return genders.count
        case self.pickerView:
            return ADBS.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case genderPickerView:
            return genders[row]
        case self.pickerView:
            return ADBS[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case genderPickerView:
            self.genderField.text = genders[row]
        case self.pickerView:
            self.adbsField.text = ADBS[row]
        default:
            break
        }
    }
}

