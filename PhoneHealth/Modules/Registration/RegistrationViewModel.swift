//
//  RegistrationViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 06/01/2022.
//

import Foundation
import Alamofire
import UIKit

struct RegistrationViewModel {
    
    var otpModel: Observable<OtpModel> = Observable(nil)
    var error: Observable<String>?
    var loading: Observable<Bool> = Observable(nil)
    
    func register(_ fullName: String, withMobileNumber mobile: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.Modules.registration, method: .post, param: ["fullName": fullName, "mobileNumber" : mobile], encoding: JSONEncoding.default, headers: [:]) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                if let model = model.data {
                    model.number = mobile
                    self.otpModel.value = model
                }
            case .failure(let error):
                self.error?.value = error.localizedDescription
            }
        }
    }
}
