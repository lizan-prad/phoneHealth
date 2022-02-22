//
//  AddConnectViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import Foundation
import Alamofire


struct AddConnectHospitalViewModel {
    
    var hospitalModel: HospitalListModel
    var success: Observable<OtpModel> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func addConnectHospital(patinetId: String, fullName: String, mobile: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/user-hospital-verification", method: .put, param: ["fullName": fullName, "hospitalId": hospitalModel.id ?? 0, "mobileNumber": mobile, "patientId": patinetId ], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.success.value = model.data
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}

