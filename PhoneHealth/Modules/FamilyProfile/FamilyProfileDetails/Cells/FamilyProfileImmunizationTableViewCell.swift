//
//  FamilyProfileImmunizationTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 15/04/2022.
//

import UIKit

class FamilyProfileImmunizationTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var strikeView: UIView!
    @IBOutlet weak var daysLeft: UILabel!
    
    func setup() {
        container.setStandardShadow()
        container.addCornerRadius(12)
        strikeView.addCornerRadius(5)
    }
    
    
}
