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
    
    var section: Int?
    
    func setup() {
        self.container.addBorder(UIColor.lightGray.withAlphaComponent(0.3))
        self.container.addCornerRadius(12)
        if allergiesLabel.text == "" || allergiesLabel.text == nil {
            self.allergiesLabel.textAlignment = .center
            self.allergiesLabel.text = section == 2 ? "User has no Allergies." : "User has no Diseases."
        }
    }
    
}
