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
    }
    
    func bindViewModel() {
        self.viewModel.success.bind { status in
            guard let nav = self.navigationController, let mobile = self.MobileNo.text, let patientId = self.patientId.text else {return}
            let coordinator = ConnectHospitalOtpCoordinator.init(navigationController: nav, model: self.viewModel.hospitalModel, mobile: mobile, patientId: patientId)
            coordinator.start()
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
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
        hospitalLogo.image = UIImage.init(named: "hospital\(viewModel.hospitalModel.value ?? 0)")
        hospitalName.text = viewModel.hospitalModel.label
        hospitalEmail.text = "\(viewModel.hospitalModel.label?.replacingOccurrences(of: " ", with: "").lowercased() ?? "")@gmail.com"
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
}
