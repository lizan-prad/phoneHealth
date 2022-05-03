//
//  HabitsViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 10/01/2022.
//

import UIKit
import MBRadioCheckboxButton
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class HabitsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var drinkFrequency: MDCOutlinedTextField!
    @IBOutlet weak var drinkNoRadio: RadioButton!
    @IBOutlet weak var drinkYesRadio: RadioButton!
    @IBOutlet weak var smokeFrequency: MDCOutlinedTextField!
    @IBOutlet weak var smokeNoRadio: RadioButton!
    @IBOutlet weak var smokeYesRadio: RadioButton!
    @IBOutlet weak var eatFrequency: MDCOutlinedTextField!
    @IBOutlet weak var foodType: MDCOutlinedTextField!
   
    var didTapNext: ((HealthProfileModel) -> ())?
    var didTapBack: ((Int) -> ())?
    
    var delegate: HealthProfileUpdateDelegate?
    
    var foodTypeData: [DynamicUserDataModel]? {
        didSet {
            self.foodTypePicker.reloadAllComponents()
        }
    }
    var selectedFoodType: DynamicUserDataModel? {
        didSet {
            foodType.text = selectedFoodType?.label
        }
    }
    
    var foodFrequency = ["1-2 meals/week", "3-5 meals/week", "More than 7 meals/week"]
    
    var snokeFrequency = ["1-2/day", "3-5/day", "5-10/day", "more than 10/day"]
    var drinkFrequencyData = ["Rare", "Social", "Regular", "Heavy"]
    
    var foodTypePicker = UIPickerView()
    var foodPicker = UIPickerView()
    var smokePicker = UIPickerView()
    var drinkPicker = UIPickerView()
    
    var viewModel: HabitsViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupPicker()
        bindViewModel()
        self.viewModel.fetchFoodType()
        self.smokeNoRadio.isOn = true
        self.smokeYesRadio.isOn = false
        
        self.drinkNoRadio.isOn = true
        self.drinkYesRadio.isOn = false
        
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        nextBtn.isEnabled = false
    }
    
    func bindViewModel() {
        self.viewModel.foodType.bind { models in
            self.foodTypeData = models
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    func setupPicker() {
        foodTypePicker.dataSource = self
        foodTypePicker.delegate = self
        
        foodPicker.dataSource = self
        foodPicker.delegate = self
        
        smokePicker.dataSource = self
        smokePicker.delegate = self
        
        drinkPicker.dataSource = self
        drinkPicker.delegate = self
        
        foodType.inputView = foodTypePicker
        eatFrequency.inputView = foodPicker
        smokeFrequency.inputView = smokePicker
        drinkFrequency.inputView = drinkPicker
    }
    
    @objc func actionNext() {
        let model = self.viewModel.model
        model?.foodType = self.selectedFoodType?.label
        model?.foodTypeId = self.selectedFoodType?.value
        model?.alcoholFrequency = self.drinkFrequency.text
        model?.doYouDrinkAlcohol = self.drinkYesRadio.isOn ? "Y" : "N"
        model?.doYouSmoke = self.smokeYesRadio.isOn ? "Y" : "N"
        model?.smokeFrequency = self.smokeFrequency.text
        model?.junkFoodFrequency = self.eatFrequency.text
        guard let model = model else {return}
        self.didTapNext?(model)
    }
    
    @objc func actionBack() {
        self.didTapBack?(4)
    }
    
    func setup() {
        smokeNoRadio.setTitle("", for: .normal)
        smokeYesRadio.setTitle("", for: .normal)
        drinkNoRadio.setTitle("", for: .normal)
        drinkYesRadio.setTitle("", for: .normal)
        
        backBtn.addBorder(UIColor.lightGray)
        nextBtn.rounded()
        backBtn.rounded()
        self.smokeFrequency.isHidden = true
        self.drinkFrequency.isHidden = true
        eatFrequency.setup("Frequency")
        smokeFrequency.setup("Frequency")
        drinkFrequency.setup("Frequency")
        foodType.setup("Food Type")
        
        smokeYesRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        smokeYesRadio.tintColor = ColorConfig.baseColor
        
        drinkYesRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        drinkYesRadio.tintColor = ColorConfig.baseColor
        
        drinkNoRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        drinkNoRadio.tintColor = ColorConfig.baseColor
        
        smokeNoRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        smokeNoRadio.tintColor = ColorConfig.baseColor
        
        smokeNoRadio.addTarget(self, action: #selector(didChangeSmokeRadioBtn(_:)), for: .touchUpInside)
        smokeYesRadio.addTarget(self, action: #selector(didChangeSmokeRadioBtn(_:)), for: .touchUpInside)
        
        drinkYesRadio.addTarget(self, action: #selector(didChangeDrinkRadioBtn(_:)), for: .touchUpInside)
        drinkNoRadio.addTarget(self, action: #selector(didChangeDrinkRadioBtn(_:)), for: .touchUpInside)
    }
    
    @objc func didChangeSmokeRadioBtn(_ sender: RadioButton) {
        switch sender {
        case smokeYesRadio:
            self.smokeYesRadio.isOn = true
            self.smokeNoRadio.isOn = false
            self.smokeFrequency.isHidden = false
        case smokeNoRadio:
            self.smokeNoRadio.isOn = true
            self.smokeYesRadio.isOn = false
            self.smokeFrequency.isHidden = true
        default:
            break
        }
        
        nextBtn.isEnabled = validate()
    }

    @objc func didChangeDrinkRadioBtn(_ sender: RadioButton) {
        
        switch sender {
        case drinkYesRadio:
            self.drinkYesRadio.isOn = true
            self.drinkNoRadio.isOn = false
            self.drinkFrequency.isHidden = false
        case drinkNoRadio:
            self.drinkNoRadio.isOn = true
            self.drinkYesRadio.isOn = false
            self.drinkFrequency.isHidden = true
        default:
            break
        }
        nextBtn.isEnabled = validate()
    }
    
    func validate() -> Bool {
        return (foodType.text != "" && eatFrequency.text != "" && ((smokeFrequency.text != "") || smokeNoRadio.isOn) && ((drinkFrequency.text != "") || drinkNoRadio.isOn))
    }

}

extension HabitsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case foodTypePicker:
            return foodTypeData?.count ?? 0
        case foodPicker:
            return foodFrequency.count
        case smokePicker:
            return snokeFrequency.count
        case drinkPicker:
            return drinkFrequencyData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case foodTypePicker:
            return foodTypeData?[row].label
        case foodPicker:
            return foodFrequency[row]
        case smokePicker:
            return snokeFrequency[row]
        case drinkPicker:
            return drinkFrequencyData[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nextBtn.isEnabled = validate()
        switch pickerView {
        case foodTypePicker:
            self.selectedFoodType = foodTypeData?[row]
        case foodPicker:
            eatFrequency.text = foodFrequency[row]
            nextBtn.isEnabled = validate()
        case smokePicker:
            smokeFrequency.text = snokeFrequency[row]
            nextBtn.isEnabled = validate()
        case drinkPicker:
            drinkFrequency.text = drinkFrequencyData[row]
            nextBtn.isEnabled = validate()
        default:
            break
        }
    }
}
