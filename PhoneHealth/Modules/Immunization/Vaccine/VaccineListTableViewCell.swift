//
//  VaccineListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import UIKit

class VaccineListTableViewCell: UITableViewCell {
    @IBOutlet weak var takeBtn: UILabel!
    
    @IBOutlet weak var vaccineDate: UILabel!
    @IBOutlet weak var vaccineName: UILabel!
    @IBOutlet weak var vaccinationTypeImage: UIImageView!
    
    var model: AvailableVaccinesList? {
        didSet {
            vaccinationTypeImage.image = UIImage.init(named: model?.vaccinationType == "Oral" ? "drop" : "injection"  )
            self.vaccineName.text = model?.vaccinationName
            let dateStr = model?.vaccinationDate?.components(separatedBy: "T").first
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: dateStr ?? "") ?? Date()
            self.takeBtn.isUserInteractionEnabled = date <= Date()
            self.takeBtn.backgroundColor = date <= Date() ? ColorConfig.baseColor : .lightGray
        }
    }
    
    var didTapTake: ((AvailableVaccinesList?) -> ())?
    
    func setup() {
        self.takeBtn.rounded()
        
        takeBtn.isUserInteractionEnabled = true
        takeBtn.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(takeAction)))
    }
    
    @objc func takeAction() {
        self.didTapTake?(self.model)
    }
}
