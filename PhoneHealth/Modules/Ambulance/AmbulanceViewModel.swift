//
//  AmbulanceViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 24/02/2022.
//

import Foundation
import Alamofire
import ObjectMapper

class AmbulanceListModel: Mappable {
    
    var ambulanceList: [AmbulanceModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ambulanceList <- map["ambulanceList"]
    }
}

class AmbulanceModel: Mappable {
    
    var address: String?
    var ambulanceId: Int?
    var contactNumber: String?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        ambulanceId <- map["ambulanceId"]
        contactNumber <- map["contactNumber"]
        name <- map["name"]
    }
}

struct AmbulanceViewModel {
    
    var ambulances: Observable<[AmbulanceModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func fetchAmbulance() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<AmbulanceListModel>.self, urlExt: URLConfig.baseUrl + "ambulance/search", method: .put, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.ambulances.value = model.data?.ambulanceList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
