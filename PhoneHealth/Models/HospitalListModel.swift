//
//  HospitalListModel.swift
//  PhoneHealth
//
//  Created by Lizan on 21/02/2022.
//

import Foundation
import ObjectMapper

class HospitalColorModel: Mappable {
    
    var hospitalColourCode: String?
    var hospitalColourId: String?
    var hospitalColourName: String?
    var isPrimary: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        hospitalColourCode <- map["hospitalColourCode"]
        hospitalColourId <- map["hospitalColourId"]
        hospitalColourName <- map["hospitalColourName"]
        isPrimary <- map["isPrimary"]
    }
}

class HospitalNoticeModel: Mappable {
    
    var description: String?
    var noticeId: Int?
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        description <- map["description"]
        noticeId <- map["noticeId"]
        title <- map["title"]
    }
}

class HospitalListModel: Mappable {
    
    var contactNumber: String?
    var hospitalAddress: String?
    var hospitalLogo: String?
    var hospitalName: String?
    
    var id: Int?
    var status: String?
    var email: String?
    var hospitalBanner: String?
    var hospitalCode: String?
    var hospitalColourDetail: [HospitalColorModel]?
    var hospitalEmail: String?
    var hospitalId: Int?
    var patientId: String?
    var hospitalNoticeDetail: [HospitalNoticeModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        contactNumber <- map["contactNumber"]
        hospitalAddress <- map["hospitalAddress"]
        hospitalLogo <- map["hospitalLogo"]
        hospitalName <- map["hospitalName"]
        id <- map["id"]
        status <- map["status"]
        hospitalBanner <- map["hospitalBanner"]
        hospitalCode <- map["hospitalCode"]
        hospitalColourDetail <- map["hospitalColourDetail"]
        hospitalEmail <- map["hospitalEmail"]
        hospitalId <- map["hospitalId"]
        patientId <- map["patientId"]
        hospitalNoticeDetail <- map["hospitalNoticeDetail"]
    }
}

class HospitalListContainerModel: Mappable {
    
    var hospital: HospitalListModel?
    var hospitalLists: [HospitalListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        hospital <- map["hospitalDetail"]
        hospitalLists <- map["hospitalDetail"]
    }
}
