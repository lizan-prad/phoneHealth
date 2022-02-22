//
//  AddConnectHospitalViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class AddConnectHospitalViewController: UIViewController, Storyboarded {

    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var hospitalContact: UILabel!
    @IBOutlet weak var hospitalEmail: UILabel!
    @IBOutlet weak var hospitalLocation: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalLogo: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var MobileNo: MDCOutlinedTextField!
    @IBOutlet weak var patientId: MDCOutlinedTextField!
    @IBOutlet weak var fullName: MDCOutlinedTextField!
    
    var viewModel: AddConnectHospitalViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupData()
        bindViewModel()
        self.hideTabbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Add Hospital"
    }
    
    func bindViewModel() {
        self.viewModel.success.bind { otp in
            guard let nav = self.navigationController, let mobile = self.MobileNo.text, let patientId = self.patientId.text else {return}
            let coordinator = ConnectHospitalOtpCoordinator.init(navigationController: nav, model: self.viewModel.hospitalModel, mobile: mobile, patientId: patientId, otp: "\(otp?.otp ?? 0)")
            coordinator.start()
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    func setup() {
        
        viewHolder.layer.cornerRadius = 12
        hospitalLogo.layer.cornerRadius = 3
        connectBtn.layer.cornerRadius = 12
        scanBtn.layer.cornerRadius = 12
        
        MobileNo.setup("Mobile No")
        patientId.setup("Patient ID")
        fullName.setup("Full Name")
        
        connectBtn.setAttributedTitle("Connect".getAtrribText(), for: .normal)
        scanBtn.setAttributedTitle("Scan and Connect".getAtrribText(), for: .normal)
        
        connectBtn.addTarget(self, action: #selector(connectAction), for: .touchUpInside)
        
        MobileNo.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        patientId.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        fullName.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        connectBtn.isEnabled = validateForm()
        switch sender {
        case MobileNo:
            MobileNo.setOutlineColor(MobileNo.text == "" ? .red : .lightGray, for: .normal)
            MobileNo.setOutlineColor(MobileNo.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case patientId:
            patientId.setOutlineColor(patientId.text == "" ? .red : .lightGray, for: .normal)
            patientId.setOutlineColor(patientId.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case fullName:
            fullName.setOutlineColor(fullName.text == "" ? .red : .lightGray, for: .normal)
            fullName.setOutlineColor(fullName.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        default:
            break
        }
    }
    
    func validateForm() -> Bool {
        return (MobileNo.text != "" && patientId.text != "" && fullName.text != "")
    }
    
    @objc func connectAction() {
        self.viewModel.addConnectHospital(patinetId: patientId.text ?? "", fullName: fullName.text ?? "", mobile: MobileNo.text ?? "")
    }
  
    func setupData() {
        hospitalLogo.sd_setImage(with: URL.init(string: viewModel.hospitalModel.hospitalLogo ?? ""))
        hospitalName.text = viewModel.hospitalModel.hospitalName
        hospitalEmail.text = "\(viewModel.hospitalModel.hospitalName?.replacingOccurrences(of: " ", with: "").lowercased() ?? "")@gmail.com"
    }

}

extension String {
    func getAtrribText() -> NSAttributedString {
        let regularAttribute = [
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)
        ]
        let regularText = NSAttributedString(string: self, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        
        newString.append(regularText)
        return newString
    }
    
    func getAtrribTextwith(_ size: CGFloat) -> NSAttributedString {
        let regularAttribute = [
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)
        ]
        let regularText = NSAttributedString(string: self, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        
        newString.append(regularText)
        return newString
    }
}

extension UIViewController {
    
    func hideTabbar() {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "HT"), object: nil)
    }
    
    func showTabbar() {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "ST"), object: nil)
    }
    
}
