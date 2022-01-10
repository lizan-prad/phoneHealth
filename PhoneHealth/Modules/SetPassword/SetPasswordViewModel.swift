//
//  SetPasswordViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import Alamofire


struct SetPasswordViewModel {
    
    var password: String?
    var confirm: String? {
        didSet {
            if password != "" {
                status.value = password == confirm
            } else {
                status.value = true
            }
        }
    }
    var error: Observable<String> = Observable(nil)
    var setPasswordModel: Observable<SetPasswordModel> = Observable(nil)
    
    var status: Observable<Bool> = Observable(false)
    
    func setPassword(password: String) {
        guard let mobile = UserDefaults.standard.value(forKey: "Mobile") as? String else {return}
        NetworkManager.shared.request(BaseMappableModel<SetPasswordModel>.self, urlExt: URLConfig.Modules.setPassword, method: .put, param: ["mobileNumber": mobile, "password": password], encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.setPasswordModel.value = model.data
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
        
    }
}
    
