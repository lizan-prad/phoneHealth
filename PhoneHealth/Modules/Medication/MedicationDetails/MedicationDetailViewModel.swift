//
//  MedicationDetailViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import Foundation
import Alamofire

struct MedicationDetailViewModel {
    
    var model: MedicationAlertModel
    
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var success: Observable<String> = Observable(nil)
    
    func medicationAction(status: String, id: String?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let param: [String:Any] = [
            "medicationId": Int(id?.components(separatedBy: "-").first ?? "") ?? 0,
              "medicationStatus": status,
              "remarks": "",
            "takenDate": "\(formatter.string(from: Date()))",
            "time": model.alertTime ?? ""
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<MedicationHistoryModel>.self, urlExt: URLConfig.baseUrl + "medication/take", method: .post, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let _):
                self.success.value = status
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func getMsg(status: String) -> String {
        switch status {
        case "S":
            return "You have skipped the alert for today."
        case "T":
            return "Thanks for taking the medication."
        case "O":
            return "You have snoozed the alert for 10mins."
        default: return ""
        }
    }
}

