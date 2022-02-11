//
//  HealthLockerListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HealthLockerListTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var logoContainer: UILabel!
    @IBOutlet weak var reportName: UILabel!
    @IBOutlet weak var reportDate: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    
    
    func setup() {
        self.container.layer.cornerRadius = 12
        logoContainer.layer.cornerRadius = 6
    }
}
