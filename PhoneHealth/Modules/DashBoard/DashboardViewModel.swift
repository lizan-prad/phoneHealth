//
//  DashboardViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import Alamofire

struct DashboardViewModel {
    var hospitals: Observable<[HospitalListModel]> = Observable([])
    var families: Observable<[FamilyProfileListModel]> = Observable([])
    var medications: Observable<[MedicationDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
 
    func fetchMedication() {
        let param: [String:Any] = [
              "frequency": "",
              "medicineName": "",
              "numberOfDays": "",
              "status": "Y"
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<MedicationListModel>.self, urlExt: URLConfig.baseUrl + "medication/search", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.medications.value = model.data?.medicationList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchFamily() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<FamilyProfilelistContainer>.self, urlExt: URLConfig.baseUrl + "user-family", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.families.value = model.data?.familyData
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchHospitals() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<HospitalListContainerModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/user/connected-hospital", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.hospitals.value = model.data?.hospitalLists
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
