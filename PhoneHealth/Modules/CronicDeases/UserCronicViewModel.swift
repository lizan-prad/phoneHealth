//
//  UserCronicViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import Foundation
import Alamofire

class UserCronicViewModel {
    
    var model: HealthProfileModel?
    var cronics: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var usModel: UserProfileModel?
    
    func fetchAllergies() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "health/disease/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.cronics.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
}
