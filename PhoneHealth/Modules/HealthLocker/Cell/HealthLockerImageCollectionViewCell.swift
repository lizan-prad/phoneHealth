//
//  HealthLockerImageCollectionViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 03/05/2022.
//

import UIKit

class HealthLockerImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lockerImage: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    
    var image: UIImage? {
        didSet {
            lockerImage.image = image
        }
    }
    var index: Int?
    
    var didTapClose: ((Int) -> ())?
    
    func setup() {
        lockerImage.addCornerRadius(12)
        
        closeBtn.rounded()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        didTapClose?(index ?? 0)
    }
}
