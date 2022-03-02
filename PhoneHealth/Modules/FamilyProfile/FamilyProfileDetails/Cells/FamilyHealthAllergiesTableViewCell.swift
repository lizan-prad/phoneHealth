//
//  FamilyHealthAllergiesTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 02/03/2022.
//

import UIKit

class FamilyHealthAllergiesTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var allergiesLabel: UILabel!
    
    func setup() {
        self.container.setStandardShadow()
        self.container.addCornerRadius(12)
    }
    
}
