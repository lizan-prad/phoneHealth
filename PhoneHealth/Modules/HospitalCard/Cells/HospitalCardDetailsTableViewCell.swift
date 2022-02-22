//
//  HospitalCardDetailsTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HospitalCardDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var emergencyView: UIView!
    @IBOutlet weak var ambulanceView: UIView!
    @IBOutlet weak var emergencyPhone: UILabel!
    @IBOutlet weak var ambulancePhone: UILabel!
    @IBOutlet weak var hospitalPhoen: UILabel!
    @IBOutlet weak var hospitalEmail: UILabel!
    @IBOutlet weak var hospitalLocation: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalLogo: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    
    var didTapEmergency: ((String) -> ())?
    var didTapAmbulance: ((String) -> ())?
    
    var model: HospitalListModel? {
        didSet {
            emergencyPhone.text = model?.contactNumber?.components(separatedBy: ",").first
            ambulancePhone.text = model?.contactNumber?.components(separatedBy: ",").last
            hospitalPhoen.text = model?.contactNumber
            hospitalEmail.text = model?.hospitalEmail
            hospitalLocation.text = model?.hospitalAddress
            hospitalName.text = model?.hospitalName
            hospitalLogo.sd_setImage(with: URL.init(string: model?.hospitalLogo ?? ""))
            backgroundImageView.sd_setImage(with: URL.init(string: model?.hospitalBanner ?? ""))
            emergencyView.isUserInteractionEnabled = true
            emergencyView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(emergencyAction)))
            ambulanceView.isUserInteractionEnabled = true
            ambulanceView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ambulanceAction)))
        }
    }
    
    @objc func emergencyAction() {
        self.didTapEmergency?(emergencyPhone.text ?? "")
    }
    
    @objc func ambulanceAction() {
        self.didTapAmbulance?(ambulancePhone.text ?? "")
    }
}
