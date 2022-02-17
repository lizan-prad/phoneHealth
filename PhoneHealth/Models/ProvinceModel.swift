//
//  ProvinceModel.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import Foundation
import ObjectMapper

class ProvinceListModel: Mappable {
    
    var addressList: [ProvinceModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        addressList <- map["addressList"]
    }
}

class ProvinceModel: Mappable {
    
    var code: String?
    var label: String?
    var value: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        label <- map["label"]
        value <- map["value"]
    }
}
