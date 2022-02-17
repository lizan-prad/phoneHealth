//
//  ProfileConfirmationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class ProfileConfirmationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var chronicDisease: UILabel!
    @IBOutlet weak var junkFOod: UILabel!
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var drinking: UILabel!
    @IBOutlet weak var smoking: UILabel!
    @IBOutlet weak var allergies: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var bloodGroup: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var viewModel: ProfileConfirmationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupData() {
        
    }
    


}
