//
//  HospitalCardReportsTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HospitalCardReportsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainCOntainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var didSelect: (() -> ())?
    
    
    func setupViews() {
        mainCOntainer.setStandardShadow()
        collectionView.register(UINib.init(nibName: "HospitalCardReportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HospitalCardReportsCollectionViewCell")
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension HospitalCardReportsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HospitalCardReportsCollectionViewCell", for: indexPath) as! HospitalCardReportsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 70, height: 80)
    }
}
