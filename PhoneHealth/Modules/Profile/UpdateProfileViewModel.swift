//
//  UpdatePasswordViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import Alamofire

struct UpdateProfileStruct {
    var avatar: String
    var dob: String
    var districtId: Int
    var email: String?
    var gender: String
    var province: Int
    var vdc: Int
    var wardNumber: String
}


struct UpdateProfileViewModel {
    
    var provinceList: Observable<[ProvinceModel]> = Observable([])
    var districtList: Observable<[ProvinceModel]> = Observable([])
    var vdcList: Observable<[ProvinceModel]> = Observable([])
    
    var error: Observable<Error> = Observable(nil)
    var success: Observable<String> = Observable(nil)
    
    func updateprofile(model: UpdateProfileStruct) {
        let param: [String: Any] = [
            "avatar": "",
            "dateOfBirth": model.dob,
            "districtId": model.districtId,
            "email": model.email ?? "",
            "gender": model.gender,
            "provinceId": model.province,
            "vdcOrMunicipalityId": model.vdc,
            "wardNumber": model.wardNumber
        ]
        
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "user/profile/update", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.success.value = model.responseStatus
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchProvince() {
        NetworkManager.shared.request(BaseMappableModel<ProvinceListModel>.self, urlExt: URLConfig.Modules.getProvinence, method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.provinceList.value = model.data?.addressList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchDistrict(provinceId: Int) {
        NetworkManager.shared.request(BaseMappableModel<ProvinceListModel>.self, urlExt: URLConfig.baseUrl + "address/new/district/\(provinceId)", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.districtList.value = model.data?.addressList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchMunicipality(districtId: Int) {
        NetworkManager.shared.request(BaseMappableModel<ProvinceListModel>.self, urlExt: URLConfig.baseUrl + "address/new/municipality/\(districtId)", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.vdcList.value = model.data?.addressList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
