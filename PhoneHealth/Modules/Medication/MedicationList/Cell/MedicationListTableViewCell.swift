//
//  MedicationListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import UIKit

class MedicationListTableViewCell: UITableViewCell {

    @IBOutlet weak var slot3: UIButton!
    @IBOutlet weak var slot2: UIButton!
    @IBOutlet weak var slot1: UIButton!
    
    @IBOutlet weak var medDate: UILabel!
    @IBOutlet weak var medQuantity: UILabel!
    @IBOutlet weak var medName: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet weak var moreBtn: UIButton!
    
    func setupViews() {
        container.addCornerRadius(12)
        slot1.rounded()
        slot2.rounded()
        slot3.rounded()
        moreBtn.setTitle("", for: .normal)
    }
}
