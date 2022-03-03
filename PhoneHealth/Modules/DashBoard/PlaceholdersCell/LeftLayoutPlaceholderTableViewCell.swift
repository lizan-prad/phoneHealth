//
//  LeftLayoutPlaceholderTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 03/03/2022.
//

import UIKit

class LeftLayoutPlaceholderTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var proceedBtn: UIButton!
    
    var didTapProceed: (() -> ())?
    
    func setup() {
        container.setStandardShadow()
        container.addCornerRadius(12)
        proceedBtn.addCornerRadius(8)
        proceedBtn.addTarget(self, action: #selector(proceedAction), for: .touchUpInside)
    }
    
    @objc func proceedAction() {
        self.didTapProceed?()
    }
}
