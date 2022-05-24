//
//  AppointmentTableViewCell.swift
//  PhoneHealth
//
//  Created by Macbook Pro on 24/05/2022.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var models: [AppointmentModel]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    func setup() {
        collectionView.register(UINib.init(nibName: "AppointmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppointmentCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension AppointmentTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCollectionViewCell", for: indexPath) as! AppointmentCollectionViewCell
        cell.setup()
        cell.model = self.models?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 30, height: 191)
    }
}
