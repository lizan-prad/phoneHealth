//
//  ConnectHospitalViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import Foundation
import Alamofire

class ConnectHospitalViewModel {
    
    var hospitals: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    
    func fetchHospitals() {
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "hospital/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.hospitals.value = model.data?.dataList
                self.fetchHospitalDetails()
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchHospitalDetails() {
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/hospital-detail", method: .put, param: ["hospitalId": hospitals.value?.first?.value ?? 0, "patientId": "1"], encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
}
