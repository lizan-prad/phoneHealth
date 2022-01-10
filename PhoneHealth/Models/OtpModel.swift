//
//  OtpModel.swift
//  PhoneHealth
//
//  Created by Lizan on 10/01/2022.
//

import Foundation
import ObjectMapper

class OtpModel: Mappable {
    
    var otp: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        otp <- map["otp"]
    }
}
