//
//  HealthLockerViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 11/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class HealthLockerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var uploadContainer: UIView!
    @IBOutlet weak var selectDocBtn: UIButton!
    @IBOutlet weak var reportTypeField: MDCOutlinedTextField!
    @IBOutlet weak var reportDateField: MDCOutlinedTextField!
    @IBOutlet weak var hospitalNameField: MDCOutlinedTextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    var viewModel: HealthLockerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        reportTypeField.setup("Report Type")
        reportDateField.setup("Report Date")
        hospitalNameField.setup("Hospital Name")
        containerView.layer.cornerRadius = 22
        saveBtn.layer.cornerRadius = 12
        selectDocBtn.layer.cornerRadius = 4
        closeBtn.setTitle("", for: .normal)
    }


}
