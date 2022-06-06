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
import LocalAuthentication

class LoginViewController: UIViewController, Storyboarded, CheckboxButtonDelegate, UITextFieldDelegate {
    
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
       
    }
    
    @IBOutlet weak var fingerStack: UIStackView!
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var MobileNumber: MDCOutlinedTextField!
    @IBOutlet weak var Password: MDCOutlinedTextField!
    @IBOutlet weak var checkBox: CheckboxButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var signUpbtn: UIButton!
    
    var viewModel: LoginViewModel!
    var context = LAContext()
    
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
        Password.isSecureTextEntry = true
        signInBtn.addTarget(self, action: #selector(proceedSignIn), for: .touchUpInside)
        signUpbtn.addTarget(self, action: #selector(proceedSignUp), for: .touchUpInside)
        
        viewModel.otp.bind { model in
            self.openOtpView(model: model)
        }
        
        
        
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
        
        forgotPasswordBtn.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
        fingerStack.isUserInteractionEnabled = true
        fingerStack.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(textFinger)))
    }
    
    @objc func textFinger() {
        faceID()
    }
    
    func faceID() {
        
        let reason = "Log in with Face ID"
        context.evaluatePolicy(
            // .deviceOwnerAuthentication allows
            // biometric or passcode authentication
            .deviceOwnerAuthentication,
            localizedReason: reason
        ) { success, error in
            if success {
                print("face")
                DispatchQueue.main.async {
                    self.Password.text = UserDefaults.standard.string(forKey: "PASS")?.components(separatedBy: ":").first
                    self.MobileNumber.text = UserDefaults.standard.string(forKey: "PASS")?.components(separatedBy: ":").last
                    self.signInBtn.isEnabled = (self.MobileNumber.text != "" && self.Password.text != "")
                }
                
                // Handle successful authentication
            } else {
                
                print(error?.localizedDescription)
//                var code = LAError.Code(rawValue: error.code)
//
//                switch code {
//                case LAError.Code.appCancel:
//                    break
//                case LAError.Code.authenticationFailed:
//                    break// The user did not provide
//                    // valid credentials
//                case LAError.Code.invalidContext:
//                    break// The LAContext was invalid
//                case LAError.Code.notInteractive:
//                    break// Interaction was not allowed so the
//                    // authentication failed
//                case LAError.Code.passcodeNotSet:
//                    break// The user has not set a passcode
//                    // on this device
//                case LAError.Code.systemCancel:
//                    break// The system canceled authentication,
//                    // for example to show another app
//                case LAError.Code.userCancel:
//                    break// The user canceled the
//                    // authentication dialog
//                case LAError.Code.userFallback:
//                    break// The user selected to use a fallback
//                    // authentication method
//                case LAError.Code.biometryLockout:
//                    break// Too many failed attempts locked
//                    // biometric authentication
//                case LAError.Code.biometryNotAvailable:
//                    break// The user's device does not support
//                    // biometric authentication
//                case LAError.Code.biometryNotEnrolled:
//                    break// The user has not configured
//                    // biometric authentication
//                @unknown default:
//                    break// An other error occurred
//                }
            }
        }
    }
    
    fileprivate func openOtpView(model: OtpModel?) {
        guard let navigationController = self.navigationController, let model = model else {return}
       
        let coordinator = OtpCoordinator.init(navigationController: navigationController, model: model)
        coordinator.isFromReset = true
        coordinator.start()
    }
    
    @objc func forgotAction() {
        let vc = UIStoryboard.init(name: "SetPassword", bundle: nil).instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        vc.didSelectMobile = { mobile in
            self.viewModel.resetPassword(mobile)
        }
        self.present(vc, animated: true)
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

