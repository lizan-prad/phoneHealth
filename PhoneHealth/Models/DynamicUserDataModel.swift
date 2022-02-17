//
//  DynamicUserDataModel.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import UIKit
import ObjectMapper

class DynamicUserDataListModel: Mappable {
    
    var dataList: [DynamicUserDataModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dataList <- map["dataList"]
    }
}

class DynamicUserDataModel: Mappable {
    
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
