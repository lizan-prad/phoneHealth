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
import Alamofire

class LoginViewController: UIViewController, Storyboarded, CheckboxButtonDelegate, UITextFieldDelegate {
    
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
        MobileNumber.delegate = self
        
        signInBtn.addTarget(self, action: #selector(proceedSignIn), for: .touchUpInside)
        signUpbtn.addTarget(self, action: #selector(proceedSignUp), for: .touchUpInside)
        
        viewModel.loginModel.bind { model in
            UserDefaults.standard.set(model?.token, forKey: "AT")
            UserDefaults.standard.set(model?.username, forKey: "Mobile")
            if model?.isProfileUpdated == "Y" {
                if model?.isHealthProfileUpdated == "Y" {
                    let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
                    appdelegate.window?.rootViewController = vc
                }else {
                    self.fetchProfile()
                }
            } else {
            guard let nav = self.navigationController else {return}
            let coordinator = UpdateProfileCoordinator.init(navigationController: nav, user: nil)
            coordinator.start()
            }
        }
        
        viewModel.error.bind { error in
            self.MobileNumber.leadingAssistiveLabel.text = error
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
        
        MobileNumber.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        Password.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }
    
    func fetchProfile() {
        self.showProgressHud()
        NetworkManager.shared.request(BaseMappableModel<UserProfileContainerModel>.self, urlExt: URLConfig.baseUrl + "user/profile/details", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.hideProgressHud()
            switch result {
            case .success(let model):
                guard let nav = self.navigationController, let model = model.data?.userProfileDetail else {return}
                let coordinator = UserSteppingCoordinator.init(navigationController: nav, model: UpdateProfileStruct.init(avatar: model.avatar ?? "", dob: model.dateOfBirth ?? "", districtId: model.districtId ?? 0, email: model.email ?? "", gender: model.gender ?? "", province: model.provinceId ?? 0, vdc: model.vdcOrMunicipalityId ?? 0, wardNumber: "\(model.wardNumber ?? "")", address: model.districtName ?? ""), usModel: model)
                coordinator.start()
                
            case .failure(let _):
                let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
                appdelegate.window?.rootViewController = vc
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let MAX_LENGTH = 10
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        signInBtn.isEnabled = (MobileNumber.text != "" && Password.text != "")
        switch sender {
        case MobileNumber:
            MobileNumber.leadingAssistiveLabel.text = ((MobileNumber.text?.count ?? 0) < 10) ? "Mobile number must be 10 digit" : ""
            
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

