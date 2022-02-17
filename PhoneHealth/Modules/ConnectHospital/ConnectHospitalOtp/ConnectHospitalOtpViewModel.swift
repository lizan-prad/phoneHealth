//
//  ConnectHospitalOtpViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import Foundation
import Alamofire

struct ConnectHospitalOtpViewModel {
    var hospitalModel: DynamicUserDataModel
    var mobile: String
    var patientId: String
    
    var success: Observable<Bool> = Observable(false)
    var error: Observable<String> = Observable(nil)
    
    func verifyOtp(otp: String) {
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.Modules.otpVerification, method: .put, param: ["otp": otp, "mobileNumber": mobile, "hospitalId": hospitalModel.value ?? 0, "patientId": patientId], encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(_ ):
                self.success.value = true
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
