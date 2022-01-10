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
    
    func login(_ mobileNo: String, loginPassword password: String) {
        NetworkManager.shared.request(BaseMappableModel<SetPasswordModel>.self, urlExt: URLConfig.Modules.login, method: .put, param: ["mobileNumber": mobileNo, "password": password], encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.loginModel.value = model.data
            case .failure(let error):
                self.error.value = error.localizedDescription
                
            }
        }
    }
}
