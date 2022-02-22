//
//  ConnectHospitalTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class ConnectHospitalTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var hospitalLogo: UIImageView!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalAddress: UILabel!
    @IBOutlet weak var hospitalPhone: UILabel!
    
    var model: HospitalListModel? {
        didSet {
            hospitalName.text = model?.hospitalName
            hospitalLogo.sd_setImage(with: URL.init(string: model?.hospitalLogo?.replacingOccurrences(of: " ", with: "%20") ?? "")) { img,_,_,_ in
                self.hospitalLogo.image = img
            }
            hospitalAddress.text = model?.hospitalAddress
            hospitalPhone.text = "\(model?.contactNumber ?? "")"
        }
    }
    
    func setup() {
        containerView.addBorder(UIColor.lightGray.withAlphaComponent(0.3))
        containerView.layer.cornerRadius = 8
        hospitalLogo.addBorder(.lightGray.withAlphaComponent(0.5))
        hospitalLogo.layer.cornerRadius = 4
    }
}
