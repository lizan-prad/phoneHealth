//
//  LoginViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import Foundation
import Alamofire

struct LoginViewModel {
    
    var loginModel: Observable<SetPasswordModel> = Observable(nil)
    var error: Observable<String> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    var otp: Observable<OtpModel> = Observable(nil)
    
    func login(_ mobileNo: String, loginPassword password: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<SetPasswordModel>.self, urlExt: URLConfig.Modules.login, method: .put, param: ["mobileNumber": mobileNo, "password": password], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                UserDefaults.standard.set(model.data?.token, forKey: "AT")
                self.loginModel.value = model.data
            case .failure(let error):
                self.error.value = error.localizedDescription
                
            }
        }
    }
    
    func resetPassword(_ mobileNo: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "user/reset-password", method: .put, param: ["mobileNumber": mobileNo], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                let otp = model.data
                otp?.number = mobileNo
                self.otp.value = otp
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
