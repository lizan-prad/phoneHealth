//
//  MedicationListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import UIKit

class MedicationListTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var medDate: UILabel!
    @IBOutlet weak var medQuantity: UILabel!
    @IBOutlet weak var medName: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: MedicationDataModel? {
        didSet {
            medName.text = model?.medicineName
            doseLabel.text = model?.medicineName?.components(separatedBy: " ").last
            let formatter = DateFormatter()
            let date = formatter.date(from: model?.firstIntake ?? "") ?? Date()
            formatter.dateFormat = "dd MMM"
            medDate.text = "\(formatter.string(from: date)) - \(formatter.string(from: date.addingTimeInterval(TimeInterval(86400*(model?.numberOfDays ?? 0)))))"
            medQuantity.text = "Quantity - \(model?.quantity ?? "0") Pills"
            collectionView.reloadData()
            collectionView.register(UINib.init(nibName: "TimeAlertCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeAlertCollectionViewCell")
        }
    }
    
    
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        container.addCornerRadius(12)
        moreBtn.setTitle("", for: .normal)
        
        container.addBorder(.lightGray.withAlphaComponent(0.2))
        
        alertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        doseLabel.addBorder(ColorConfig.baseColor)
        doseLabel.textColor = ColorConfig.baseColor
        doseLabel.addCornerRadius(2)
    }
}

extension MedicationListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.frequency ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeAlertCollectionViewCell", for: indexPath) as! TimeAlertCollectionViewCell
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 77, height: 30)
    }
}
