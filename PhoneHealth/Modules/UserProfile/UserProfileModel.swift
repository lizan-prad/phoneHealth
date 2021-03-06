//
//  UserProfileModel.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import Foundation
import ObjectMapper
import UIKit

class UserProfileContainerModel: Mappable {
    
    var userProfileDetail: UserProfileModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userProfileDetail <- map["userProfileDetail"]
    }
}

class ChronicDiseaseModel: Mappable {
    var diseaseId: Int?
    var diseaseName: String?
    var userDiseaseInfoId: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        diseaseId <- map["diseaseId"]
        diseaseName <- map["diseaseName"]
        userDiseaseInfoId <- map["userDiseaseInfoId"]
    }
}

class AllergyModel: Mappable {
    var allergyId: Int?
    var allergyName: String?
    var userAllergyInfoId: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        allergyId <- map["allergyId"]
        allergyName <- map["allergyName"]
        userAllergyInfoId <- map["userAllergyInfoId"]
    }
}



class UserProfileModel: Mappable {
    
    var alcoholFrequency: String?
    var avatar: String?
    var bloodGroupId: Int?
    var bloodGroupName: String?
    var dateOfBirth: String?
    var districtId: Int?
    var districtName: String?
    var doYouDrinkAlcohol: String?
    var doYouSmoke: String?
    var email: String?
    var foodTypeId: Int?
    var foodTypeName: String?
    var gender: String?
    var haveAllergies: String?
    var haveCronicDisease: String?
    var height: Double?
    var immunizationMinInfo: String?
    var id: Int?
    var junkFoodFrequency: String?
    var name: String?
    var provinceId: Int?
    var provinceName: String?
    var relation: String?
    var relationCode: String?
    var relationId: Int?
    var smokeFrequency: String?
    var userAllergyInfo: [AllergyModel]?
    var userDiseaseInfo: [ChronicDiseaseModel]?
    var userHealthInfoId: Int?
    var vdcOrMunicipalityId: Int?
    var vdcOrMunicipalityName: String?
    var wardNumber: String?
    var weight: Int?

    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        alcoholFrequency <- map["alcoholFrequency"]
        avatar <- map["avatar"]
        bloodGroupId <- map["bloodGroupId"]
        bloodGroupName <- map["bloodGroupName"]
        dateOfBirth <- map["dateOfBirth"]
        districtId <- map["districtId"]
        districtName <- map["districtName"]
        doYouDrinkAlcohol <- map["doYouDrinkAlcohol"]
        doYouSmoke <- map["doYouSmoke"]
        email <- map["email"]
        foodTypeId <- map["foodTypeId"]
        foodTypeName <- map["foodTypeName"]
        gender <- map["gender"]
        haveAllergies <- map["haveAllergies"]
        haveCronicDisease <- map["haveCronicDisease"]
        height <- map["height"]
        id <- map["id"]
        immunizationMinInfo <- map["immunizationMinInfo.daysLeft"]
        junkFoodFrequency <- map["junkFoodFrequency"]
        name <- map["name"]
        provinceId <- map["provinceId"]
        provinceName <- map["provinceName"]
        smokeFrequency <- map["smokeFrequency"]
        userAllergyInfo <- map["userAllergyInfo"]
        relation <- map["relation"]
        relationCode <- map["relationCode"]
        relationId <- map["relationId"]
        userDiseaseInfo <- map["userDiseaseInfo"]
        userHealthInfoId <- map["userHealthInfoId"]
        vdcOrMunicipalityId <- map["vdcOrMunicipalityId"]
        vdcOrMunicipalityName <- map["vdcOrMunicipalityName"]
        wardNumber <- map["wardNumber"]
        weight <- map["weight"]
    }
}
