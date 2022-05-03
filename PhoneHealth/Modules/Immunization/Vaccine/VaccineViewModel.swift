//
//  VaccineViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import Foundation
import Alamofire
import ObjectMapper

struct VaccinationData : Mappable {
    var vaccinationInfo : VaccinationInfo?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vaccinationInfo <- map["vaccinationInfo"]
    }

}

struct ImmunizationVaccineHIstoryData : Mappable {
    var history : [ImmunizationVaccineHIstoryList]?
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        history <- map["vaccinationHistoryList"]
        
    }
}

struct ImmunizationVaccineHIstoryList : Mappable {
    var title : String?
    var availableVaccinesList : [AvailableVaccinesList]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        title <- map["title"]
        availableVaccinesList <- map["availableVaccinesList"]
    }
}

struct AvailableVaccineList : Mappable {
    var title : String?
    var availableVaccinesList : [AvailableVaccinesList]?
    
    init() {}
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        title <- map["title"]
        availableVaccinesList <- map["availableVaccinesList"]
    }

}

struct UpcomingVaccinationList : Mappable {
    var vaccinationId : Int?
    var vaccinationName : String?
    var description : String?
    var daysLeft : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vaccinationId <- map["vaccinationId"]
        vaccinationName <- map["vaccinationName"]
        description <- map["description"]
        daysLeft <- map["daysLeft"]
    }

}


struct AvailableVaccinesList : Mappable {
    var vaccinationId : Int?
    var vaccinationName : String?
    var vaccinationType : String?
    var description : String?
    var code : String?
    var time : String?
    var vaccinationDate : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vaccinationId <- map["vaccinationId"]
        vaccinationName <- map["vaccinationName"]
        vaccinationType <- map["vaccinationType"]
        description <- map["description"]
        code <- map["code"]
        time <- map["time"]
        vaccinationDate <- map["vaccinationDate"]
    }

}


struct VaccinationInfo : Mappable {
    var userId : Int?
    var name : String?
    var age : String?
    var dateOfBirth : String?
    var avatar : String?
    var upcomingVaccinationList : [UpcomingVaccinationList]?
    var availableVaccineList : [AvailableVaccineList]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        userId <- map["userId"]
        name <- map["name"]
        age <- map["age"]
        dateOfBirth <- map["dateOfBirth"]
        avatar <- map["avatar"]
        upcomingVaccinationList <- map["upcomingVaccinationList"]
        availableVaccineList <- map["availableVaccineList"]
    }

}


struct VaccineViewModel {
    
    var childModel: ImmunizationProfileModel?
    
    var history: Observable<[ImmunizationVaccineHIstoryList]> = Observable([])
    
    var success: Observable<String> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var models: Observable<VaccinationInfo> = Observable(nil)
    
    func fetchVaccinationList() {
        let param: [String:Any] = [
            "childId": childModel?.id ?? 0
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<VaccinationData>.self, urlExt: URLConfig.baseUrl + "immunization/min", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.models.value = model.data?.vaccinationInfo
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchVaccinationHistoryList(id: Int?) {
        let param: [String:Any] = [
            "childId": id ?? 0
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<ImmunizationVaccineHIstoryData>.self, urlExt: URLConfig.baseUrl + "immunization/vaccination/history", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.history.value = model.data?.history
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func takeAction(model: ImmunizationTakeModel?, vaccine: AvailableVaccinesList?, id: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let param: [String:Any] = [
            "childId": id,
            "location": model?.location ?? "",
            "remarks": model?.remarks ?? "",
            "takenDate": formatter.string(from: model?.date ?? Date()),
            "time": vaccine?.time ?? "",
            "vaccinationDate": vaccine?.vaccinationDate ?? "",
            "vaccineId": vaccine?.vaccinationId ?? 0
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<VaccinationData>.self, urlExt: URLConfig.baseUrl + "immunization/vaccination/take", method: .post, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let _):
                self.success.value = "Vaccination taken added."
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
