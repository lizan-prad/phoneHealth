//
//  UserCronicViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import MBRadioCheckboxButton
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class UserCronicViewController: UIViewController, Storyboarded,  UITableViewDataSource, UITableViewDelegate {

    var viewModel: UserCronicViewModel!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectDiseases: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var noRadio: RadioButton!
    @IBOutlet weak var yesRadio: RadioButton!
    @IBOutlet weak var otherField: MDCOutlinedTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var didTapNext: ((Int) -> ())?
    var didTapBack: ((Int) -> ())?
    var selectedCronics = [String]()
    
    var allergies: [String] {
        return ["Diabetes", "Blood Pressure", "Hypothyroidism", "Migraine", "Asthama"]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.yesRadio.isOn = true
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
    }
    
    @objc func actionNext() {
        self.didTapNext?(2)
    }
    
    @objc func actionBack() {
        self.didTapBack?(2)
    }
    
    func setup() {
        nextBtn.isEnabled = false
        yesRadio.setTitle("", for: .normal)
        noRadio.setTitle("", for: .normal)
        backBtn.addBorder(UIColor.lightGray)
        nextBtn.rounded()
        backBtn.rounded()
        tableView.dataSource = self
        tableView.delegate = self
        otherField.setup("Other Diseases")
        self.tableViewHeight.constant = CGFloat(self.allergies.count*50)
        
        yesRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        yesRadio.tintColor = ColorConfig.baseColor
        noRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        noRadio.tintColor = ColorConfig.baseColor
        
        yesRadio.addTarget(self, action: #selector(didChangeRadioBtn(_:)), for: .touchUpInside)
        noRadio.addTarget(self, action: #selector(didChangeRadioBtn(_:)), for: .touchUpInside)
    }
    
    @objc func didChangeRadioBtn(_ sender: RadioButton) {
        self.nextBtn.isEnabled = validate()
        switch sender {
        case yesRadio:
            self.yesRadio.isOn = true
            self.noRadio.isOn = false
            self.tableView.isHidden = false
            self.selectDiseases.isHidden = false
            otherField.isHidden = false
        case noRadio:
            self.selectedCronics = []
            self.tableView.reloadData()
            self.noRadio.isOn = true
            self.yesRadio.isOn = false
            self.tableView.isHidden = true
            self.selectDiseases.isHidden = true
            otherField.isHidden = true
        default:
            break
        }
    }
 
    func validate() -> Bool {
        return (noRadio.isOn && selectedCronics.count != 0) || yesRadio.isOn
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCronicTableViewCell") as! UserCronicTableViewCell
        cell.checkBox.setTitle("", for: .normal)
        cell.checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        cell.contentView.addBorder(UIColor.black.withAlphaComponent(0.2))
        cell.contentView.addCornerRadius(12)
        cell.checkBox.isOn = false
        cell.checkBox.delegate = cell
        cell.didSelectDeselect = { (index, status) in
            if status {
                
                self.selectedCronics.append(self.allergies[index ?? 0])
                self.nextBtn.isEnabled = self.validate()
            } else {
                if self.selectedCronics.count != 0 {
                let removingIndex: Int = self.selectedCronics.enumerated().filter({$0.element == self.allergies[index ?? 0]}).map({$0.offset}).first ?? 0
                self.selectedCronics.remove(at: removingIndex)
                self.nextBtn.isEnabled = self.validate()
                }
            }
        }
        cell.allergyTitle.text = allergies[indexPath.row]
        return cell
    }
    


}
