//
//  MedicationHistoryTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 15/04/2022.
//

import UIKit

class MedicationHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var dateRange: UILabel!
    @IBOutlet weak var mg: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var medicationName: UILabel!
    @IBOutlet weak var container: UIView!
    
    var model: MedicationHistoryDataModel? {
        didSet {
            mg.addBorder(ColorConfig.baseColor)
            mg.textColor = ColorConfig.baseColor
            mg.addCornerRadius(2)
            container.addBorder(.lightGray.withAlphaComponent(0.3))
            timeRange.text = model?.time?.compactMap({$0.time}).joined(separator: ", ")
            desc.text = model?.info
            dateRange.text = model?.range
            mg.text = "\(model?.medicineDose ?? "") mg"
            quantity.text =  "Quantity - \(model?.medicineQuantity ?? "") Pills"
            medicationName.text = model?.medicineName
        }
    }
    
    func setup() {
        container.addCornerRadius(12)
    }
}
