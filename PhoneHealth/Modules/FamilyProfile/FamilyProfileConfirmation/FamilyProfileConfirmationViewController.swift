//
//  FamilyProfileConfirmationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit

class FamilyProfileConfirmationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var chronicDisease: UILabel!
    @IBOutlet weak var junkFOod: UILabel!
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var drinking: UILabel!
    @IBOutlet weak var smoking: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
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
    
    
    var viewModel: FamilyProfileConfirmationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setup()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        bindViewModel()
    }
    
    func bindViewModel() {
        self.viewModel.success.bind { status in
            self.showAlert(title: nil, message: "Family Health Profile \(self.viewModel.model?.familyData?.fullName ?? "") registration completed.") { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
        
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    func setupData() {
        userProfileImage.rounded()
        container.addCornerRadius(12)
        container.addBorder(UIColor.lightGray.withAlphaComponent(0.3))
        backBtn.rounded()
        nextBtn.rounded()
        nextBtn.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
    }
    
    @objc func finishAction() {
        self.viewModel.uploadFamilyHealth()
    }
    
    func setup() {
        self.name.text = viewModel.model?.familyData?.fullName
        self.id.text = UserDefaults.standard.value(forKey: "Mobile") as? String
        self.bloodGroup.text = self.viewModel.model?.bloodGroup
        self.height.text = (viewModel.model?.height ?? "") + " ft"
        self.age.text = self.viewModel.model?.familyData?.dateOfBirth
        self.weight.text = (viewModel.model?.weight ?? "") + "kg"
        self.allergies.text = "\(self.viewModel.model?.userAllergyInfo?.map({$0.allergyName ?? ""}).joined(separator: ", ") ?? "")"
        self.smoking.text = viewModel.model?.doYouSmoke
        self.drinking.text = viewModel.model?.doYouDrinkAlcohol
        self.foodType.text = viewModel.model?.foodType
        self.junkFOod.text = viewModel.model?.junkFoodFrequency
        self.chronicDisease.text = "\(self.viewModel.model?.userDiseaseInfo?.map({$0.diseaseName ?? ""}).joined(separator: ", ") ?? "")"
        
        
    }
    
}
