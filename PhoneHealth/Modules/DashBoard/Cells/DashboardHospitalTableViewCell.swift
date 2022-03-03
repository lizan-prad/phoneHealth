//
//  DashboardHospitalTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 03/03/2022.
//

import UIKit

class DashboardHospitalTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var didselect: ((HospitalListModel?) -> ())?
    
    
    var models: [HospitalListModel]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    func setup() {
        self.container.setStandardShadow()
        self.container.addCornerRadius(12)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "DashboardHospitalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardHospitalCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardHospitalCollectionViewCell", for: indexPath) as! DashboardHospitalCollectionViewCell
        cell.hospitalLogo.sd_setImage(with: URL.init(string: models?[indexPath.row].hospitalLogo ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didselect?(self.models?[indexPath.row])
    }
}
