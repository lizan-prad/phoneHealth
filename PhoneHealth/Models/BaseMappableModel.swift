//
//  BaseMappableModel.swift
//  PhoneHealth
//
//  Created by Lizan on 10/01/2022.
//

import Foundation
import ObjectMapper

class BaseMappableModel<T: Mappable>: Mappable {
    
    var data: T?
    var responseCode: Int?
    var responseStatus: String?
    var errorMessage: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        responseCode <- map["responseCode"]
        responseStatus <- map["responseStatus"]
        errorMessage <- map["errorMessage"]
    }
}
