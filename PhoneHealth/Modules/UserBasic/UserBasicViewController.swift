//
//  UserBasicViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class UserBasicViewController: UIViewController, Storyboarded {

    @IBOutlet weak var bloodGroup: MDCOutlinedTextField!
    @IBOutlet weak var inches: MDCOutlinedTextField!
    @IBOutlet weak var feet: MDCOutlinedTextField!
    @IBOutlet weak var kg: MDCOutlinedTextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var setupLaterBtn: UIButton!
    
    var didTapNext: ((Int) -> ())?
    var didTapBack: ((Int) -> ())?
    var viewModel: UserBasicViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    func setupView() {
       
        backBtn.addBorder(UIColor.black)
        bloodGroup.setup("Blood Group")
        feet.setup("Feet")
        inches.setup("Inches")
        kg.setup("KG")
        
        backBtn.rounded()
        nextBtn.rounded()
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        setupLaterBtn.addTarget(self, action: #selector(setupLater), for: .touchUpInside)
    }
    
    @objc func setupLater() {
        guard let nav = self.navigationController else {return}
        let coordinator = DashboardCoordinator.init(navigationController: nav)
        appdelegate.window?.rootViewController = coordinator.getMainView()
    }
    
    @objc func actionNext() {
        self.didTapNext?(1)
    }
    
    @objc func actionBack() {
        self.didTapBack?(1)
    }
    

}
