//
//  UserBasicInfoTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class UserBasicInfoTableViewCell: UITableViewCell {

   
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bloodGroup: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    var model: UserProfileModel? {
        didSet {
            bloodGroup.text = model?.bloodGroupName
            height.text = "\(model?.height ?? 0)ft"
            weight.text = "\(model?.weight ?? 0)kg"
        }
    }
    
    func setup() {
        self.container.addBorder(UIColor.lightGray.withAlphaComponent(0.3))
        self.container.addCornerRadius(12)
        
    }
}
