//
//  MedicationViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import Foundation
import Alamofire
import ObjectMapper

class MedicationDataModel: Mappable {
    
    var firstIntake: String?
    var frequency: Int?
    var medicationId: Int?
    var medicineName: String?
    var numberOfDays: Int?
    var quantity: String?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        firstIntake <- map["firstIntake"]
        frequency <- map["frequency"]
        medicationId <- map["medicationId"]
        medicineName <- map["medicineName"]
        numberOfDays <- map["numberOfDays"]
        quantity <- map["quantity"]
        status <- map["status"]
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

struct MedicationViewModel {
    
    var medications: Observable<[MedicationDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
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
