//
//  UserBasicViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

struct AllergyDetailModel {
    var allergyId: Int?
    var allergyName: String?
    var isPrimary: String?
    var status: String?
}

struct DiseaseDetailModel {
    var diseaseId: Int?
    var diseaseName: String?
    var isPrimary: String?
    var status: String?
}

class HealthProfileModel {
    var alcoholFrequency: String?
    var bloodGroupId: Int?
    var doYouDrinkAlcohol: String?
    var doYouSmoke: String?
    var foodTypeId: Int?
    var haveAllergies: String?
    var haveCronicDease: String?
    var height: String?
    var junkFoodFrequency: String?
    var smokeFrequency: String?
    var userAllergyInfo: [AllergyDetailModel]?
    var userDiseaseInfo: [DiseaseDetailModel]?
    var weight: String?
}

protocol HealthProfileUpdateDelegate {
    func didUpdatePage(index: Int, model: HealthProfileModel?)
}

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
    var delegate: HealthProfileUpdateDelegate?
    
    var bloodGroups: [DynamicUserDataModel]? {
        didSet {
            pickerBlood.reloadAllComponents()
        }
    }
    
    var selectedBloodGroup: DynamicUserDataModel? {
        didSet {
            bloodGroup.text = selectedBloodGroup?.label
        }
    }
    
    var feetData = [String]()
    var inchesData = [String]()
    var kgData = [String]()
    
    var pickerBlood = UIPickerView()
    var pickerFeet = UIPickerView()
    var pickerInches = UIPickerView()
    var pickerKG = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.fetchBloodGroups()
        setupPicker()
        feetData = (0 ..< 8).map({"\($0)"})
        inchesData = (0 ..< 13).map({"\($0)"})
        kgData = (0 ..< 200).map({"\($0)"})
        nextBtn.isEnabled = false
    }
    
    func bindViewModel() {
        viewModel.bloodGroups.bind { models in
            self.bloodGroups = models
        }
    }
    
    func setupPicker() {
        pickerBlood.dataSource = self
        pickerBlood.delegate = self
        
        pickerFeet.dataSource = self
        pickerFeet.delegate = self
        
        pickerInches.dataSource = self
        pickerInches.delegate = self
        
        pickerKG.dataSource = self
        pickerKG.delegate = self
        
        bloodGroup.inputView = pickerBlood
        feet.inputView = pickerFeet
        inches.inputView = pickerInches
        kg.inputView = pickerKG
    }
    
    func setupView() {
       
        backBtn.addBorder(UIColor.lightGray)
        bloodGroup.setup("Blood Group")
        feet.setup("Feet")
        inches.setup("Inches")
        kg.setup("KG")
        
        backBtn.rounded()
        nextBtn.rounded()
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        setupLaterBtn.addTarget(self, action: #selector(setupLater), for: .touchUpInside)
        
        bloodGroup.addTarget(self, action: #selector(textCHanged(_:)), for: .allEditingEvents)
        feet.addTarget(self, action: #selector(textCHanged(_:)), for: .allEditingEvents)
        inches.addTarget(self, action: #selector(textCHanged(_:)), for: .allEditingEvents)
        kg.addTarget(self, action: #selector(textCHanged(_:)), for: .allEditingEvents)
    }
    
    @objc func setupLater() {
        guard let nav = self.navigationController else {return}
        let coordinator = DashboardCoordinator.init(navigationController: nav)
        appdelegate.window?.rootViewController = coordinator.getMainView()
    }
    
    @objc func textCHanged(_ sender: MDCOutlinedTextField) {
        self.nextBtn.isEnabled = validate()
    }
    
    func validate() -> Bool {
        return bloodGroup.text != "" && feet.text != "" && inches.text != "" && kg.text != ""
    }
    
    @objc func actionNext() {
        let model = HealthProfileModel()
        model.bloodGroupId = self.selectedBloodGroup?.value
        model.weight = self.kg.text
        model.height = "\(self.feet.text ?? "").\(self.inches.text ?? "")"
        self.delegate?.didUpdatePage(index: 1, model: model)
        self.didTapNext?(1)
    }
    
    @objc func actionBack() {
        self.didTapBack?(1)
    }
    

}

extension UserBasicViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case pickerBlood:
            return bloodGroups?.count ?? 0
        case pickerFeet:
            return feetData.count
        case pickerInches:
            return inchesData.count
        case pickerKG:
            return kgData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pickerBlood:
            return bloodGroups?[row].label
        case pickerFeet:
            return feetData[row]
        case pickerInches:
            return inchesData[row]
        case pickerKG:
            return kgData[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pickerBlood:
            self.selectedBloodGroup = bloodGroups?[row]
        case pickerFeet:
            feet.text = feetData[row]
        case pickerInches:
            inches.text = inchesData[row]
        case pickerKG:
            kg.text = kgData[row]
        default:
            break
        }
    }
}
