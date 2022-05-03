//
//  SetPasswordViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import Alamofire

let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let numbers = "0123456789!@#$%^&*"


struct SetPasswordViewModel {
    
    var password: String? {
        didSet {
            if (password?.count ?? 0) < 8 {
                status.value = (false,"Passowrd must be 8 characters")
            } else if validateCapital(str: password ?? "") {
                status.value = (false,"Password must contain 1 capital letter")
            } else if validateLower(str: password ?? "") {
                status.value = (false,"Password must contain 1 lower cased letter")
            } else if validateNumbers(str: password ?? "") {
                status.value = (false,"Password must contain 1 number or special character")
            }
            else {
                status.value = (true, "")
            }
        }
    }
    
    var confirm: String? {
        didSet {
        
            confirmStatus.value = ((password == confirm), "Password doesn't match")
           
        }
    }
    
    func validateLower(str: String) -> Bool {
        return letters.lowercased().filter { a in
            return str.contains(a)
        }.count == 0
    }
    
    func validateNumbers(str: String) -> Bool {
        return numbers.filter { a in
            return str.contains(a)
        }.count == 0
    }
    
    func validateCapital(str: String) -> Bool {
        return letters.filter { a in
            return str.contains(a)
        }.count == 0
    }
    
    var error: Observable<String> = Observable(nil)
    var setPasswordModel: Observable<SetPasswordModel> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    var status: Observable<(Bool,String)> = Observable((false,""))
    
    var confirmStatus: Observable<(Bool,String)> = Observable((false,""))
    
    func setPassword(password: String) {
        guard let mobile = UserDefaults.standard.value(forKey: "Mobile") as? String else {return}
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<SetPasswordModel>.self, urlExt: URLConfig.Modules.setPassword, method: .put, param: ["mobileNumber": mobile, "password": password], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.setPasswordModel.value = model.data
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
        
    }
}
    
