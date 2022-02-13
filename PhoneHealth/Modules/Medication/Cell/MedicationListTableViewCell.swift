//
//  MedicationListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import UIKit

class MedicationListTableViewCell: UITableViewCell {

   
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var timeContainer: UIView!
    @IBOutlet weak var medDate: UILabel!
    @IBOutlet weak var medQuantity: UILabel!
    @IBOutlet weak var medName: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet weak var moreBtn: UIButton!
    
    func setupViews() {
        container.addCornerRadius(12)
        moreBtn.setTitle("", for: .normal)
        timeContainer.addBorder(.black.withAlphaComponent(0.2))
        timeContainer.rounded()
        container.addBorder(.lightGray.withAlphaComponent(0.2))
        
        alertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        doseLabel.addBorder(ColorConfig.baseColor)
        doseLabel.textColor = ColorConfig.baseColor
        doseLabel.addCornerRadius(2)
    }
}
