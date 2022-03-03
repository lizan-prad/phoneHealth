//
//  ProfileCardTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class ProfileCardTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var subBackground: UIView!
    @IBOutlet weak var backgroundsView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    var model: UserProfileModel? {
        didSet {
            self.nameLabel.text = model?.name
            self.profileImageLabel.sd_setImage(with: URL.init(string: model?.avatar ?? "")) { img, error, _, _ in
               
//                if img?.imageOrientation != .up {
                self.profileImageLabel.image = img
//                }
               
            }
            self.idLabel.text = "\(UserDefaults.standard.value(forKey: "Mobile") as? String ?? "")"
            self.locationLabel.text = model?.districtName
            self.emailLabel.text = model?.email
            self.dobLabel.text = model?.dateOfBirth
            self.genderLabel.text = model?.gender
        }
    }
    
    func setup() {
        self.subBackground.addCornerRadius(8)
        self.backImage.addCornerRadius(12)
        self.gradientView.addCornerRadius(12)
        self.backgroundsView.addCornerRadius(12)
        self.gradientView.setGradientLeftRight(UIColor.black, endColor: UIColor.init(hex: "22D7F2"))
        self.backgroundsView.addBorder(UIColor.lightGray.withAlphaComponent(0.2))
        
        profileImageLabel.addCornerRadius(35)
        profileImageLabel.addBorderwith(.white, width: 3)
        
    }
    
}
