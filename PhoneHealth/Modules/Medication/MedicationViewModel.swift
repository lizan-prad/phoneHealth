//
//  MedicationViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import Foundation
import Alamofire
import ObjectMapper

class MedicationTimeModel: Mappable {
    var id: Int?
    var time: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        time <- map["time"]
    }
}

//"medicationHistoryId": 1,
//        "medicationId": null,
//        "medicineName": "Omeprazole",
//        "medicineQuantity": "1",
//        "range": "10 Apr-10 May",
//        "info": "Every day, take 2 pills a day",
//        "medicineDose": "20 mg",
//        "time": [
//          {
//            "id": 1,
//            "time": "05:45"
//          },
//          {
//            "id": 2,
//            "time": "14:45"
//          }

class MedicationHistoryDataModel: Mappable {
    
    var medicationHistoryId: Int?
    var range: String?
    var info: String?
    var medicationId: Int?
    var medicineName: String?
    var medicineQuantity: String?
    var medicineDose: String?
    var time: [MedicationTimeModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        medicationHistoryId <- map["medicationHistoryId"]
        range <- map["range"]
        medicationId <- map["medicationId"]
        medicineName <- map["medicineName"]
        info <- map["info"]
        medicineQuantity <- map["medicineQuantity"]
        medicineDose <- map["medicineDose"]
        time <- map["time"]
    }
}
          
class MedicationDataModel: Mappable {
    
    var firstIntake: String?
    var expiryDate: String?
    var frequency: Int?
    var medicationId: Int?
    var dose: String?
    var medicineName: String?
    var numberOfDays: Int?
    var quantity: String?
    var status: String?
    var time: [MedicationTimeModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        firstIntake <- map["firstIntake"]
        frequency <- map["frequency"]
        medicationId <- map["medicationId"]
        medicineName <- map["medicineName"]
        numberOfDays <- map["numberOfDays"]
        quantity <- map["quantity"]
        dose <- map["dose"]
        status <- map["status"]
        time <- map["time"]
        expiryDate <- map["expiryDate"]
    }
}

class MedicationListModel: Mappable {
    
    var medicationList: [MedicationDataModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        medicationList <- map["medicationList"]
    }
}

class MedicationHistoryModel: Mappable {
    
    var medicationList: [MedicationHistoryDataModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        medicationList <- map["medicationHistoryList"]
    }
}

struct MedicationViewModel {
    
    var medications: Observable<[MedicationDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var isFromNotif = false
    var model: MedicationAlertModel?
    
    func fetchMedication() {
        let param: [String:Any] = [
              "frequency": "",
              "medicineName": "",
              "numberOfDays": "",
              "status": "Y"
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<MedicationListModel>.self, urlExt: URLConfig.baseUrl + "medication/search", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.medications.value = model.data?.medicationList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
