//
//  AmbulanceTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 24/02/2022.
//

import UIKit

class AmbulanceTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalPhoneBtn: UIButton!
    @IBOutlet weak var hospitalTitle: UILabel!
    
    var didTapCall: ((Int) -> ())?
    var index: Int?
    
    var model: AmbulanceModel? {
        didSet {
            hospitalTitle.text = model?.name
        }
    }
    
    func setup() {
        hospitalPhoneBtn.setTitle("", for: .normal)
        hospitalPhoneBtn.addTarget(self, action: #selector(callBtnAction), for: .touchUpInside)
    }
    
    @objc func callBtnAction() {
        didTapCall?(index ?? 0)
    }

}
