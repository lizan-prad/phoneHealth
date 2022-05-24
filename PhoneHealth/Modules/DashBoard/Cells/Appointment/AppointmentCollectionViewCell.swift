//
//  AppointmentCollectionViewCell.swift
//  PhoneHealth
//
//  Created by Macbook Pro on 24/05/2022.
//

import UIKit

class AppointmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var dateContainer: UIView!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var appointmentCategory: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var apoointmentTIME: UILabel!
    @IBOutlet weak var appointmentFor: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var model: AppointmentModel? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = Date.init(timeIntervalSince1970: Double(model?.appointmentDate ?? 0)/1000)
            hospitalName.text = model?.hospitalName
            appointmentCategory.text = model?.specializationName
            doctorName.text = model?.doctorName
            apoointmentTIME.text = model?.appointmentTime
            appointmentFor.text = "N/A"
            formatter.dateFormat = "eee"
            self.dayLabel.text = formatter.string(from: date)
            formatter.dateFormat = "MMM"
            self.monthLabel.text = formatter.string(from: date)
            formatter.dateFormat = "dd"
            self.dateLabel.text = formatter.string(from: date)
        }
    }
    
    func setup() {
        dateContainer.addCornerRadius(8)
        container.addCornerRadius(12)
    }
}
