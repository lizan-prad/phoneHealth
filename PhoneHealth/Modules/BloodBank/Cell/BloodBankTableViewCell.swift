//
//  BloodBankTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import UIKit

class BloodBankTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalPhoneBtn: UIButton!
    @IBOutlet weak var hospitalTitle: UILabel!
    
    var didTapCall: ((Int) -> ())?
    var index: Int?
    
    var model: BloodBankModel? {
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
