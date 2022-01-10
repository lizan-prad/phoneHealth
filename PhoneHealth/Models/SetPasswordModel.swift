//
//  SetPassword.swift
//  PhoneHealth
//
//  Created by Lizan on 10/01/2022.
//

import Foundation
import ObjectMapper

class SetPasswordModel: Mappable {
    
    var token: String?
    var username: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        username <- map["username"]
    }
}
