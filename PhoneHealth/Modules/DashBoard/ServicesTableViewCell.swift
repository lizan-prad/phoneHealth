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
    var didSelectEappointment: (() -> ())?
    
    func setupView() {
        self.container.backgroundColor = .white
        self.collectionview.backgroundColor = .white
        self.container.setStandardShadow()//addBorder(UIColor.lightGray.withAlphaComponent(0.3))
        self.container.addCornerRadius(8)
    }
    
    func setup() {
        collectionview.dataSource = self
        collectionview.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearviceCollectionViewCell", for: indexPath) as! SearviceCollectionViewCell
        cell.serviceIcon.image = UIImage.init(named: services?[indexPath.row].image ?? "")
        cell.container.addCornerRadius(12)
        cell.serviceIcon.tintColor = .white //indexPath.row == 0 ? UIColor.init(hex: "1ECBE1") : ( indexPath.row == 1 ? UIColor.init(hex: "FFCC2C") : ( indexPath.row == 2 ? UIColor.init(hex: "F58992") : UIColor.init(hex: "1FB6BA")))
        cell.container.backgroundColor = indexPath.row == 0 ? UIColor.init(hex: "1ECBE1").withAlphaComponent(1) : ( indexPath.row == 1 ? UIColor.init(hex: "FFCC2C").withAlphaComponent(1) : ( indexPath.row == 2 ? UIColor.init(hex: "F58992").withAlphaComponent(1) : UIColor.init(hex: "9067D6").withAlphaComponent(1)))
//        cell.serviceName.text = services?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionview.frame.width/4) - 10, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.didSelectLocker?()
        case 1:
            self.didSelectEappointment?()
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
