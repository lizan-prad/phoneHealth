//
//  UserProfileModel.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import Foundation
import ObjectMapper

class UserProfileContainerModel: Mappable {
    
    var userProfileDetail: UserProfileModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userProfileDetail <- map["userProfileDetail"]
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
    var id: Int?
    var junkFoodFrequency: String?
    var name: String?
    var provinceId: Int?
    var provinceName: String?
    var smokeFrequency: String?
    var userAllergyInfo: String?
    var userDiseaseInfo: String?
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
        junkFoodFrequency <- map["junkFoodFrequency"]
        name <- map["name"]
        provinceId <- map["provinceId"]
        provinceName <- map["provinceName"]
        smokeFrequency <- map["smokeFrequency"]
        userAllergyInfo <- map["userAllergyInfo"]
        userDiseaseInfo <- map["userDiseaseInfo"]
        userHealthInfoId <- map["userHealthInfoId"]
        vdcOrMunicipalityId <- map["vdcOrMunicipalityId"]
        vdcOrMunicipalityName <- map["vdcOrMunicipalityName"]
        wardNumber <- map["wardNumber"]
        weight <- map["weight"]
    }
}
