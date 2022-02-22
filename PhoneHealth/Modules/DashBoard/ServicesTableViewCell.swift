//
//  ServicesTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

struct ServiceModel {
    var image: String?
    var name: String?
}

class ServicesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    
    var services: [ServiceModel]? {
        didSet {
            collectionview.reloadData()
        }
    }
    
    var didSelectLocker: (() -> ())?
    var didSelectMedication: (() -> ())?
    
    func setup() {
        self.container.setStandardShadow()//addBorder(UIColor.lightGray.withAlphaComponent(0.3))
        self.container.addCornerRadius(8)
        collectionview.dataSource = self
        collectionview.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearviceCollectionViewCell", for: indexPath) as! SearviceCollectionViewCell
        cell.serviceIcon.image = UIImage.init(named: services?[indexPath.row].image ?? "")
        cell.serviceName.text = services?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionview.frame.width/3) - 10, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.didSelectLocker?()
        case 1:
            break
        case 2:
            self.didSelectMedication?()
        default:
            break
        }
    }
}

extension UIView {
    
    func setStandardShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 4
        self.layer.shadowOffset = CGSize.init(width: 1, height: 2)
        self.layer.shadowRadius = 4
    }
}
