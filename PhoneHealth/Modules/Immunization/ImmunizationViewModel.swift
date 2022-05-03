//
//  ImmunizationViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import Foundation
import Alamofire

struct ImmunizationViewModel {
    
    var childModel: ImmunizationProfileModel?
    
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var models: Observable<VaccinationInfo> = Observable(nil)
    
    func fetchVaccinationList() {
        let param: [String:Any] = [
            "childId": childModel?.id ?? 0
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<VaccinationData>.self, urlExt: URLConfig.baseUrl + "immunization/min", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.models.value = model.data?.vaccinationInfo
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
