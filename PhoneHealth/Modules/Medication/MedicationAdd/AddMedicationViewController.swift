//
//  AddMedicationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class AddMedicationViewController: UIViewController {

    @IBOutlet weak var numberOfDays: MDCOutlinedTextField!
    @IBOutlet weak var firstIntake: MDCOutlinedTextField!
    @IBOutlet weak var frequency: MDCOutlinedTextField!
    @IBOutlet weak var quantity: MDCOutlinedTextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var medicineName: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        numberOfDays.setup("Number of Days")
        firstIntake.setup("First Intake")
        frequency.setup("Frequency")
        quantity.setup("Quantity")
        medicineName.setup("Medicine Name")
        saveBtn.addCornerRadius(12)
    }

}
