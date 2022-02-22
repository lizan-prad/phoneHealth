//
//  HospitalCardViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import Foundation
import Alamofire

struct HospitalCardViewModel {
    
    var hospitalModel: HospitalListModel?
    var loading: Observable<Bool> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var model: Observable<HospitalListModel> = Observable(nil)
    
    func fetchHospitalDetail() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<HospitalListContainerModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/hospital-detail", method: .put, param: ["hospitalId": 1, "patientId": 1], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.model.value = model.data?.hospital
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
