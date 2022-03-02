//
//  DashboardFamilyProfileTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit

class DashboardFamilyProfileTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var addView: UIView!
    
    var didTapAdd: (() -> ())?
    var didSelectRow: ((Int) -> ())?
    
    var model: [FamilyProfileListModel]? {
        didSet {
            self.collectionVIew.reloadData()
        }
    }
    
    func setupCollection() {
        self.addView.addBorder(ColorConfig.baseColor)
        self.addView.addCornerRadius(8)
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        collectionVIew.register(UINib.init(nibName: "DashboardAddMedicationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardAddMedicationCollectionViewCell")
    }
    
    func setup() {
        container.setStandardShadow()
        container.addCornerRadius(12)
        addView.isUserInteractionEnabled = true
        addView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addAction)))
    }

    @objc func addAction() {
        self.didTapAdd?()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardAddMedicationCollectionViewCell", for: indexPath) as! DashboardAddMedicationCollectionViewCell
        cell.setup()
        cell.namelabel.text = self.model?[indexPath.row].name?.components(separatedBy: " ").first
        cell.plusIcon.sd_setImage(with: URL.init(string: self.model?[indexPath.row].avatar ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 65, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectRow?(indexPath.row)
    }
}
