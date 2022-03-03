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
    
    var models: [HealthLockerListModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTapOpen: ((HealthLockerListModel?) -> ())?
    var didTapAdd: (() -> ())?
    func setup() {
        self.addCOntainer.addBorder(ColorConfig.baseColor)
        self.addCOntainer.addCornerRadius(8)
        self.container.setStandardShadow()
        self.container.addCornerRadius(12)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "FamilyHealthLockerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FamilyHealthLockerCollectionViewCell")
        
        addCOntainer.isUserInteractionEnabled = true
        addCOntainer.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addAction)))
    }
    
    @objc func addAction() {
        self.didTapAdd?()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didTapOpen?(self.models?[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (models?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyHealthLockerCollectionViewCell", for: indexPath) as! FamilyHealthLockerCollectionViewCell
        cell.model = models?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 90, height: 80)
    }
}
