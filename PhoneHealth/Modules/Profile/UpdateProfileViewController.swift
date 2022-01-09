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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
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
    }
    
    @objc func actionNext() {
        guard let navigationController = self.navigationController else {return}
        let coodinator = UserSteppingCoordinator.init(navigationController: navigationController)
        coodinator.start()
    }

}
