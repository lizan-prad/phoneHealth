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
    
    func setupViews() {
        collectionView.register(UINib.init(nibName: "HospitalCardReportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HospitalCardReportsCollectionViewCell")
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension HospitalCardReportsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
