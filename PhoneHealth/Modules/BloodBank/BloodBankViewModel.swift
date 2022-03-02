//
//  BloodBankViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import Foundation
import Alamofire
import ObjectMapper

class BloodBankListModel: Mappable {
    
    var bloodbankList: [BloodBankModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        bloodbankList <- map["bloodBankList"]
    }
}

class BloodBankModel: Mappable {
    
    var address: String?
    var bloodBankId: Int?
    var contactNumber: String?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        bloodBankId <- map["bloodBankId"]
        contactNumber <- map["contactNumber"]
        name <- map["name"]
    }
}

struct BloodBankViewModel {
    
    var bloodBanks: Observable<[BloodBankModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func fetchBloodBank() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<BloodBankListModel>.self, urlExt: URLConfig.baseUrl + "blood-bank/search", method: .put, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.bloodBanks.value = model.data?.bloodbankList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
