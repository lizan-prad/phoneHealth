//
//  AddFamilyProfileViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 27/02/2022.
//

import Foundation
import Alamofire
import ObjectMapper

class FamilyResponseIdModel: Mappable {
    
    var userId: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
    }
}

struct AddFamilyProfileViewModel {
    
    var model: Observable<UserProfileModel> = Observable(nil)
    var relations: Observable<[DynamicUserDataModel]> = Observable([])
    var bloodGroups: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var success: Observable<String> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func fetchRelations() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "user-family/relation/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.relations.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func updateprofile(model: FmailyProfileStruct) {
        let param: [String: Any] = [
            "avatar": model.avatar ?? "",
            "dateOfBirth": model.dateOfBirth ?? "",
            "districtId": model.districtId ?? 0,
            "email": model.email ?? "",
            "gender": model.gender ?? "",
            "provinceId": model.provinceId ?? 0,
            "relationId": model.relationId ?? 0,
            "fullName": model.fullName ?? "",
            "vdcOrMunicipalityId": model.vdcOrMunicipalityId ?? 0,
            "wardNumber": model.wardNumber ?? ""
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<FamilyResponseIdModel>.self, urlExt: URLConfig.baseUrl + "user-family/profile/update", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.success.value = "\(model.data?.userId ?? 0)"
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchProfile() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<UserProfileContainerModel>.self, urlExt: URLConfig.baseUrl + "user/profile/details", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.model.value = model.data?.userProfileDetail
                
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchBloodGroups() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "health/bloodGroup/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                bloodGroups.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
