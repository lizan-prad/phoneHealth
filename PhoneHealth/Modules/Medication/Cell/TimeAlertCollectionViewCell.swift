//
//  TimeAlertCollectionViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class TimeAlertCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setup() {
        self.contentView.addBorder(.black.withAlphaComponent(0.2))
        self.contentView.rounded()
    }
}
