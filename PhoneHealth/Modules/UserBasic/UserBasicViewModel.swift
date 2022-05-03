//
//  UserBasicViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import Alamofire

struct UserBasicViewModel {
    
    var bloodGroups: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var model: UserProfileModel?
    
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
