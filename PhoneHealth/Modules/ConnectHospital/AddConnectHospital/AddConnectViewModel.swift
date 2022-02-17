//
//  AddConnectViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import Foundation
import Alamofire


struct AddConnectHospitalViewModel {
    
    var hospitalModel: DynamicUserDataModel
    var success: Observable<String> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    
    func addConnectHospital(patinetId: String, fullName: String, mobile: String) {
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/user-hospital-verification", method: .put, param: ["fullName": fullName, "hospitalId": hospitalModel.value ?? 0, "mobileNumber": mobile, "patientId": patinetId ], encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.success.value = model.responseStatus
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}

