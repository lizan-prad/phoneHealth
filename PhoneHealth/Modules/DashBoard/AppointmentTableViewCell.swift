//
//  AppointmentTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var dateContainer: UIView!
    @IBOutlet weak var container: UIView!
    
    func setup() {
        container.addCornerRadius(12)
        dateContainer.addCornerRadius(8)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
