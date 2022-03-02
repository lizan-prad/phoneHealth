//
//  DashboardAddMedicationCollectionViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 24/02/2022.
//

import UIKit

class DashboardAddMedicationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var plusIcon: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    
    func setup() {
        
        self.plusIcon.rounded()
        
    }

}
