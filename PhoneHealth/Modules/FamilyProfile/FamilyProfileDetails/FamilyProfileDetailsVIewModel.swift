//
//  FamilyProfileDetailsVIewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import Foundation
import ObjectMapper

class FamilyProfilelistContainer: Mappable {
    
    var familyData: [FamilyProfileListModel]?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        familyData <- map["familyDetail"]
    }
}

class FamilyProfileListModel: Mappable {
    
    var id: Int?
    var name: String?
    var relation: String?
    var avatar: String?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        relation <- map["relation"]
        avatar <- map["avatar"]
    }

}

struct FamilyProfileDetailsViewModel {
    
}
