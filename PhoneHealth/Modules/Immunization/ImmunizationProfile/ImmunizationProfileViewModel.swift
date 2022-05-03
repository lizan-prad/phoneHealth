//
//  ImmunizationProfileViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import Foundation
import Alamofire
import ObjectMapper

class ImmunizationProfileModel: Mappable {
    
    var id: Int?
    var name: String?
    var avatar: String?
    var age: String?
    
    init() {}
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        age <- map["age"]
    }
    
}

class ImmunizationProfileListModel: Mappable {
    
    var childrenDetail: [ImmunizationProfileModel]?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        childrenDetail <- map["childrenDetail"]
    }
    
}

struct ImmunizationProfileViewModel {
    
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var models: Observable<[ImmunizationProfileModel]> = Observable([])
    
    func fetchImmunizationList() {

        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<ImmunizationProfileListModel>.self, urlExt: URLConfig.baseUrl + "immunization/children-profile", method: .put, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.models.value = model.data?.childrenDetail
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
