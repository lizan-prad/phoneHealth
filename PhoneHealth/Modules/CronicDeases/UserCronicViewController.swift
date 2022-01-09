//
//  UserCronicViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import MBRadioCheckboxButton

class UserCronicViewController: UIViewController, Storyboarded,  UITableViewDataSource, UITableViewDelegate {

    var viewModel: UserCronicViewModel!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var noRadio: RadioButton!
    @IBOutlet weak var yesRadio: RadioButton!
    @IBOutlet weak var tableView: UITableView!
    
    var didTapNext: ((Int) -> ())?
    var didTapBack: ((Int) -> ())?
    
    var allergies: [String] {
        return ["Diabetes", "Blood Pressure", "Hypothyroidism", "Migraine", "Asthama", "Other Diseases"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        backBtn.addBorder(UIColor.lightGray)
        nextBtn.rounded()
        backBtn.rounded()
        tableView.dataSource = self
        tableView.delegate = self
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCronicTableViewCell") as! UserCronicTableViewCell
        cell.checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        cell.contentView.addBorder(UIColor.black.withAlphaComponent(0.2))
        cell.contentView.addCornerRadius(12)
        cell.allergyTitle.text = allergies[indexPath.row]
        if indexPath.row == (self.allergies.count - 1) {
            cell.contentView.addBorder(UIColor.black.withAlphaComponent(0.6))
        }
        return cell
    }
    


}
