//
//  ConnectHospitalViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import Foundation
import Alamofire

class ConnectHospitalViewModel {
    
    var hospitals: Observable<[HospitalListModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func fetchHospitals() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<HospitalListContainerModel>.self, urlExt: URLConfig.baseUrl + "hospital/available-connect-hospital", method: .put, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.hospitals.value = model.data?.hospitalLists
//                self.fetchHospitalDetails()
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
//    func fetchHospitalDetails() {
//        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/hospital-detail", method: .put, param: ["hospitalId": hospitals.value?.first?.value ?? 0, "patientId": "1"], encoding: JSONEncoding.default, headers: nil) { result in
//            switch result {
//            case .success(let model):
//                break
//            case .failure(let error):
//                break
//            }
//        }
//    }
}
