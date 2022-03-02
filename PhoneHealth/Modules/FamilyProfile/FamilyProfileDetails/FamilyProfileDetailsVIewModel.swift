//
//  FamilyProfileDetailsVIewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import Foundation
import ObjectMapper
import Alamofire

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
    
    var model: FamilyProfileListModel?
    var success: Observable<UserProfileModel> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func fetchProfile() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<UserProfileContainerModel>.self, urlExt: URLConfig.baseUrl + "user-family/profile/details/\(model?.id ?? 0)", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.success.value = model.data?.userProfileDetail
            case .failure(let error):
                self.error.value = error
            }
        }
        
    }
}
