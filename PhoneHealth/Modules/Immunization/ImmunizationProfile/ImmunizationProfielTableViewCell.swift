//
//  ImmunizationProfielTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import UIKit
import SDWebImage

class ImmunizationProfielTableViewCell: UITableViewCell {
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var viewDetailsBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var strikeView: UIView!
    @IBOutlet weak var conatiner: UIView!
    
    var model: ImmunizationProfileModel? {
        didSet {
            age.text = "Age: \(model?.age ?? "")"
            name.text = model?.name
            if model?.avatar == nil {
                profileImage.tintColor = .lightGray
                profileImage.image = UIImage.init(named: "profile")
            } else {
                profileImage.sd_setImage(with: URL.init(string: model?.avatar ?? ""))
            }
        }
    }
    
    func setup() {
        shadowView.setStandardShadow()
        shadowView.addCornerRadius(12)
        profileImage.rounded()
        conatiner.addCornerRadius(12)
        strikeView.addCornerRadius(10)
        viewDetailsBtn.rounded()
    }
}
