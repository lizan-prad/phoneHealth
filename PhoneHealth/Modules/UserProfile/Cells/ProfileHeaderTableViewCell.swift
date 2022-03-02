//
//  ProfileHeaderTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 02/03/2022.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var downImage: UIImageView!
    
    @IBOutlet weak var container: UIView!
    
    var didTap: ((Int, Bool) -> ())?
    var section: Int?
    var showing = true
    func setup() {
        container.addCornerRadius(8)
        container.addBorder(.lightGray.withAlphaComponent(0.3))
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapAction)))
    }
    
    @objc func tapAction() {
        showing = !showing
        self.didTap?(section ?? 0, showing)
    }
}
