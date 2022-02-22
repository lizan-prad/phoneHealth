//
//  HealthLockerListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import SDWebImage

class HealthLockerListTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var logoContainer: UILabel!
    @IBOutlet weak var reportName: UILabel!
    @IBOutlet weak var reportDate: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    
    var model: HealthLockerListModel? {
        didSet {
            logoImage.layer.cornerRadius = 8
            logoImage.sd_setImage(with: URL.init(string: model?.thumbnails ?? ""))
            reportName.text = model?.reportTypeName
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            let date = dateFormatter.date(from: model?.date ?? "")
            dateFormatter.dateFormat = "mmmm dd yyyy"
            reportDate.text = dateFormatter.string(from: date ?? Date())
            hospitalName.text = model?.hospitalName
            
        }
    }
    
    func setup() {
        self.container.addBorder(.lightGray.withAlphaComponent(0.3))
        self.container.layer.cornerRadius = 12
        logoContainer.layer.cornerRadius = 8
    }
}
