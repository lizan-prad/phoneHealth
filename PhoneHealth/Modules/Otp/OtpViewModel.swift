//
//  OtpViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import Foundation
import Alamofire

struct OtpViewModel {
    
    var model: OtpModel
    
    var success: Observable<Bool> = Observable(false)
    var error: Observable<String> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func verifyOtp(otp: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.Modules.otpVerification, method: .put, param: ["otp": otp, "mobileNumber": model.number ?? ""], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(_ ):
                self.success.value = true
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
