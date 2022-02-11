//
//  ConnectHospitalTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class ConnectHospitalTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var hospitalLogo: UIImageView!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalAddress: UILabel!
    @IBOutlet weak var hospitalPhone: UILabel!
    

    func setup() {
        containerView.layer.cornerRadius = 8
        hospitalLogo.addBorder(.lightGray.withAlphaComponent(0.5))
        hospitalLogo.layer.cornerRadius = 4
    }
}
