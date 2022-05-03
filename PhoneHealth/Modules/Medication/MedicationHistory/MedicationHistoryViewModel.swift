//
//  MedicationHistoryViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 15/04/2022.
//

import Foundation
import Alamofire

struct MedicationHistoryViewModel {
    
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var medications: Observable<[MedicationHistoryDataModel]> = Observable([])
    
    func fetchMedication() {
        let param: [String:Any] = [
              "medicineName": ""
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<MedicationHistoryModel>.self, urlExt: URLConfig.baseUrl + "medication/history/search", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.medications.value = model.data?.medicationList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
