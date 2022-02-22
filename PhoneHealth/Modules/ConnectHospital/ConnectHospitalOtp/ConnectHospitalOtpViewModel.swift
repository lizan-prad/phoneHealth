//
//  ConnectHospitalOtpViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import Foundation
import Alamofire

struct ConnectHospitalOtpViewModel {
    var hospitalModel: HospitalListModel
    var mobile: String
    var patientId: String
    var otp: String
    
    var success: Observable<Bool> = Observable(false)
    var error: Observable<String> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func verifyOtp() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.Modules.otpVerification, method: .put, param: ["otp": otp, "mobileNumber": mobile, "hospitalId": hospitalModel.id ?? 0, "patientId": patientId], encoding: JSONEncoding.default, headers: nil) { result in
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
