//
//  UserAlleryViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import MBRadioCheckboxButton

class UserAlleryViewController: UIViewController, Storyboarded, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var noRadio: RadioButton!
    @IBOutlet weak var yesRadio: RadioButton!
    var viewModel: UserAllergyViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    var didTapNext: ((Int) -> ())?
    var didTapBack: ((Int) -> ())?
    
    var allergies: [String] {
        return ["Grass and tree pollen", "Dust Mites", "Animal Dander, Hair, etc", "Food: Egg, nuts, shelfish", "Latex: gloves, condoms, etc", "Chemicals: Detergent"]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserAllergyTableViewCell") as! UserAllergyTableViewCell
        cell.checkBox.checkBoxColor = CheckBoxColor.init(activeColor: ColorConfig.baseColor, inactiveColor: UIColor.white, inactiveBorderColor: UIColor.lightGray, checkMarkColor: UIColor.white)
        cell.contentView.addBorder(UIColor.black.withAlphaComponent(0.2))
        cell.contentView.addCornerRadius(12)
        cell.allergyTitle.text = allergies[indexPath.row]
        return cell
    }

}
