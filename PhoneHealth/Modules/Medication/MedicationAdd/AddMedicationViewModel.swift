//
//  AddMedicationViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import Foundation
import Alamofire

struct MedicaitonModel {
    var firstIntake: String?
    var frequency: Int?
    var medicineName: String?
    var numberOfDays: Int?
    var quantity: String?
    
}

struct AddMedicationViewModel {
    
    var success: Observable<Bool> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func addMedicaiton(model: MedicaitonModel) {
        let param: [String: Any] = [
            "firstIntake": model.firstIntake ?? "",
            "frequency": model.frequency ?? 0,
            "medicineName": model.medicineName ?? "",
            "numberOfDays": model.numberOfDays ?? 0,
            "quantity": model.quantity ?? ""
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "medication", method: .post, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(_):
                self.success.value = true
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
