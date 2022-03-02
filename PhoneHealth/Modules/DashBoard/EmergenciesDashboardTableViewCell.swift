//
//  EmergenciesDashboardTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 02/03/2022.
//

import UIKit

class EmergenciesDashboardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        collectionview.register(UINib.init(nibName: "EmergencyDashboardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmergencyDashboardCollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmergencyDashboardCollectionViewCell", for: indexPath) as! EmergencyDashboardCollectionViewCell
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
            self.didSelectEappointment?()
            break
        case 2:
            self.didSelectMedication?()
        default:
            break
        }
    }
}
