//
//  UserAlleryViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import MBRadioCheckboxButton

class UserAlleryViewController: UIViewController, Storyboarded, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectAllergy: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var noRadio: RadioButton!
    @IBOutlet weak var yesRadio: RadioButton!
    var viewModel: UserAllergyViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    var didTapNext: ((Int) -> ())?
    var didTapBack: ((Int) -> ())?
    var delegate: HealthProfileUpdateDelegate?
    
    var selectedAllergies = [DynamicUserDataModel?]()
    
    var allergies: [DynamicUserDataModel]? {
        didSet {
            tableViewHeight.constant = CGFloat((self.allergies?.count ?? 0)*50)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
        self.viewModel.fetchAllergies()
        self.yesRadio.setTitle("", for: .normal)
        self.noRadio.setTitle("", for: .normal)
        self.yesRadio.isOn = true
        yesRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        yesRadio.tintColor = ColorConfig.baseColor
        noRadio.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray) 
        noRadio.tintColor = ColorConfig.baseColor
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        yesRadio.addTarget(self, action: #selector(didChangeRadioBtn(_:)), for: .touchUpInside)
        noRadio.addTarget(self, action: #selector(didChangeRadioBtn(_:)), for: .touchUpInside)
    }
    
    func bindViewModel() {
        self.viewModel.allergies.bind { models in
            self.allergies = models
        }
        
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    @objc func didChangeRadioBtn(_ sender: RadioButton) {
        self.nextBtn.isEnabled = validate()
        switch sender {
        case yesRadio:
            self.yesRadio.isOn = true
            self.noRadio.isOn = false
            self.tableView.isHidden = false
            self.selectAllergy.isHidden = false
        case noRadio:
            self.selectedAllergies = []
            self.tableView.reloadData()
            self.noRadio.isOn = true
            self.yesRadio.isOn = false
            self.tableView.isHidden = true
            self.selectAllergy.isHidden = true
        default:
            break
        }
    }
    
    func validate() -> Bool {
        return (noRadio.isOn && selectedAllergies.count != 0) || yesRadio.isOn
    }
    
    @objc func actionNext() {
        let model = self.viewModel.model
        model?.haveAllergies = self.yesRadio.isOn ? "Y" : "N"
        model?.userAllergyInfo = self.selectedAllergies.map({AllergyDetailModel.init(allergyId: $0?.value, allergyName: $0?.label, isPrimary: "N", status: "N")})
        self.delegate?.didUpdatePage(index: 2, model: model)
        self.didTapNext?(2)
    }
    
    @objc func actionBack() {
        self.didTapBack?(2)
    }
    
    func setup() {
        backBtn.addBorder(UIColor.lightGray)
        nextBtn.rounded()
        backBtn.rounded()
        tableView.dataSource = self
        tableView.delegate = self
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserAllergyTableViewCell") as! UserAllergyTableViewCell
        cell.checkBox.setTitle("", for: .normal)
        cell.checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        cell.contentView.addBorder(UIColor.black.withAlphaComponent(0.2))
        cell.contentView.addCornerRadius(12)
        cell.checkBox.isOn = false
        cell.index = indexPath.row
        cell.checkBox.delegate = cell
        cell.didSelectDeselect = { (index, status) in
            if status {
                self.selectedAllergies.append(self.allergies?[index ?? 0])
                self.nextBtn.isEnabled = self.validate()
            } else {
                if self.selectedAllergies.count != 0 {
                    let removingIndex: Int = self.selectedAllergies.enumerated().filter({$0.element?.value == self.allergies?[index ?? 0].value}).map({$0.offset}).first ?? 0
                self.selectedAllergies.remove(at: removingIndex)
                self.nextBtn.isEnabled = self.validate()
                }
            }
        }
        cell.allergyTitle.text = allergies?[indexPath.row].label
        return cell
    }

}
