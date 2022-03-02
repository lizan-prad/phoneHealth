//
//  DashboardMedicationCollectionViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 24/02/2022.
//

import UIKit

class DashboardMedicationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var medsIcon: UIImageView!
    @IBOutlet weak var medsTitle: UILabel!
    
    
    var model: MedicationDataModel? {
        didSet {
            self.medsTitle.text = model?.medicineName
            self.medsIcon.tintColor = (model?.medicationId ?? 0)%2 == 0 ? ColorConfig.baseColor : .gray
        }
    }
}
