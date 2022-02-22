//
//  HealthLockerListViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import Alamofire

struct HealthLockerListViewModel {
    
    var models: Observable<[HealthLockerListModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func searchHealthLocker() {
        let param: [String: Any] = [
            "hospitalName": "",
             "name": "",
             "status": ""
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<HealthLockerListConatinerModel>.self, urlExt: URLConfig.baseUrl + "healthLocker/search", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.models.value = model.data?.healthLockerList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
