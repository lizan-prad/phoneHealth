//
//  UserCronicTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import MBRadioCheckboxButton

class UserCronicTableViewCell: UITableViewCell, CheckboxButtonDelegate {

    var index: Int?
    
    var didSelectDeselect: ((Int?,Bool) -> ())?
    
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        self.didSelectDeselect?(index, true)
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        self.didSelectDeselect?(index, false)
    }
    
    @IBOutlet weak var allergyTitle: UILabel!
    @IBOutlet weak var checkBox: CheckboxButton!

}
