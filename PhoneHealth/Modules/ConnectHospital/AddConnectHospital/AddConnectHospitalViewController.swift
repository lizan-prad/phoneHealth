//
//  AddConnectHospitalViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class AddConnectHospitalViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        viewHolder.layer.cornerRadius = 8
        hospitalLogo.layer.cornerRadius = 3
        connectBtn.layer.cornerRadius = 8
        scanBtn.layer.cornerRadius = 8
        
        MobileNo.setup("Mobile No")
        patientId.setup("Patient ID")
        fullName.setup("Full Name")
    }
  

}
