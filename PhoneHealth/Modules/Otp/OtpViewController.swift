//
//  OtpViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import KAPinField
import Alamofire

class OtpViewController: UIViewController, Storyboarded {

    @IBOutlet weak var otpIcon: UIImageView!
    @IBOutlet weak var pinView: KAPinField!
    @IBOutlet weak var verifyBtn: UIButton!
    
    var viewModel: OtpViewModel!
    var otp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        self.view.setGradient(UIColor.init(hex: "E7F5F4"), endColor: UIColor.init(hex: "72C6BD"))
        otpIcon.addCornerRadius(otpIcon.frame.height/2)
        verifyBtn.addCornerRadius(12)
        otpIcon.layer.borderWidth = 0.5
        otpIcon.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        pinView.properties.delegate = self
        pinView.properties.validCharacters = "0123456789"
        pinView.properties.animateFocus = true
        pinView.becomeFirstResponder()
        pinView.appearance.font = .menloBold(40) // Default to appearance.MonospacedFont.menlo(40)
        pinView.appearance.kerning = 20 // Space between characters, default to 16
        pinView.appearance.textColor = UIColor.black.withAlphaComponent(0.6) // Default to nib color or black if initialized programmatically
        pinView.appearance.tokenColor = UIColor.white.withAlphaComponent(0.3) // token color, default to text color
        pinView.appearance.tokenFocusColor = UIColor.white.withAlphaComponent(0.3)  // token focus color, default to token color
        pinView.appearance.backOffset = 4 // Backviews spacing between each other
        pinView.appearance.backColor = UIColor.white
        pinView.appearance.backBorderWidth = 0.4
        pinView.appearance.backBorderColor = UIColor.black.withAlphaComponent(0.2)
        pinView.appearance.backCornerRadius = 12
        pinView.appearance.backFocusColor = UIColor.white
        pinView.appearance.backBorderFocusColor = UIColor.init(hex: "46C9BD")
        pinView.appearance.backActiveColor = UIColor.white
        pinView.appearance.backBorderActiveColor = UIColor.init(hex: "46C9BD")
        pinView.appearance.keyboardType = UIKeyboardType.numberPad // Specify keyboard type
        verifyBtn.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
    }
    
    fileprivate func bindViewModel() {
        self.viewModel.success.bind({ status in
            self.openSetPassword()
        })
        
        self.viewModel.error.bind({ error in
            let alert = AlertServices.showAlertWithOkAction(title: nil, message: error) { _ in
                self.pinView.reloadAppearance()
            }
            self.present(alert, animated: true, completion: nil)
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func openSetPassword() {
        guard let navigationController = self.navigationController else {return}
        let coordinator = SetPasswordCoordinator.init(navigationController: navigationController)
        coordinator.start()
    }
    
    @objc func actionVerify() {
        if otp?.count == 4 {
            if otp == "\(self.viewModel.model.otp ?? 0)" {
                self.viewModel.verifyOtp(otp: otp ?? "")
            } else {
                self.showAlert(title: nil, message: "Invalid Otp!") { _ in
                    self.pinView.reloadAppearance()
                }
            }
            
        }
        
    }

}

extension OtpViewController : KAPinFieldDelegate {
    
    func pinField(_ field: KAPinField, didFinishWith code: String) {
        self.otp = code
    }

}
