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
    
    func get24Hrs(str: String) -> String {
        let val = str.components(separatedBy: ":").first ?? ""
        let last = str.components(separatedBy: ":").last ?? ""
        
        return (Int(val) ?? 0) < 12 ? (str + " am") : "\(((Int(val) ?? 0) + 12) - 24):\(last) pm".replacingOccurrences(of: "-", with: "")
    }
    
    var model: MedicationHistoryDataModel? {
        didSet {
            mg.addBorder(ColorConfig.baseColor)
            mg.textColor = ColorConfig.baseColor
            mg.addCornerRadius(2)
            container.addBorder(.lightGray.withAlphaComponent(0.3))
            timeRange.text = model?.time?.compactMap({ m in
                let alarmFormat = DateFormatter()
                alarmFormat.dateFormat = "HH:mm"
    //            alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT")
                let time = "\(self.get24Hrs(str: m.time ?? ""))"
                alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT-6.15")
                let date = alarmFormat.date(from: time) ?? Date()
                alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT")
                return alarmFormat.string(from: date)
            }).joined(separator: ", ")
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
