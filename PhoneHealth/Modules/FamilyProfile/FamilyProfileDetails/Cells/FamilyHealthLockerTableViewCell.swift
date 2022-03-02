//
//  FamilyHealthLockerTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit

class FamilyHealthLockerTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var addCOntainer: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var medications: [MedicationDataModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTapOpen: ((MedicationDataModel?) -> ())?
    var didTapAdd: (() -> ())?
    func setup() {
        self.addCOntainer.addBorder(ColorConfig.baseColor)
        self.addCOntainer.addCornerRadius(8)
        self.container.setStandardShadow()
        self.container.addCornerRadius(12)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "DashboardMedicationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardMedicationCollectionViewCell")

        addCOntainer.isUserInteractionEnabled = true
        addCOntainer.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addAction)))
    }
    
    @objc func addAction() {
        self.didTapAdd?()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didTapOpen?(self.medications?[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (medications?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardMedicationCollectionViewCell", for: indexPath) as! DashboardMedicationCollectionViewCell

        cell.model = medications?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 80, height: 70)
    }
}
