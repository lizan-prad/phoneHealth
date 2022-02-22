//
//  HealthLockerListModel.swift
//  PhoneHealth
//
//  Created by Lizan on 21/02/2022.
//

import Foundation
import ObjectMapper

class HealthLockerListConatinerModel: Mappable {
    
    var healthLockerList: [HealthLockerListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        healthLockerList <- map["healthLockerList"]
    }
}

class HealthLockerListModel: Mappable {
    
    var date: String?
    var healthLockerId: Int?
    var hospitalName: String?
    var reportTypeName: String?
    var status: String?
    var thumbnails: String?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        healthLockerId <- map["healthLockerId"]
        hospitalName <- map["hospitalName"]
        reportTypeName <- map["reportTypeName"]
        status <- map["status"]
        thumbnails <- map["thumbnails"]
    }
}
