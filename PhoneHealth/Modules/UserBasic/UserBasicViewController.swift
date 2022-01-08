//
//  UserBasicViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class UserBasicViewController: UIViewController {

    @IBOutlet weak var step5: UIView!
    @IBOutlet weak var step4: UIView!
    @IBOutlet weak var step3: UIView!
    @IBOutlet weak var step2: UIView!
    @IBOutlet weak var step1: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bloodGroup: MDCOutlinedTextField!
    @IBOutlet weak var inches: MDCOutlinedTextField!
    @IBOutlet weak var feet: MDCOutlinedTextField!
    @IBOutlet weak var kg: MDCOutlinedTextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var setupLaterBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    func setupView() {
        step1.rounded()
        step2.rounded()
        step3.rounded()
        step4.rounded()
        step5.rounded()
        step1.addBorder(UIColor.init(hex: "46C9BD"))
        backBtn.addBorder(UIColor.init(hex: "46C9BD"))
        bloodGroup.setup("Blood Group")
        feet.setup("Feet")
        inches.setup("Inches")
        kg.setup("KG")
        
        backBtn.rounded()
        nextBtn.rounded()
        container.addCornerRadius(36)
        
    }
    

}
