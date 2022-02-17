//
//  HealthLockerViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 11/02/2022.
//

import Foundation
import Alamofire

struct HealthLockerViewModel {
    
    
    func addHealthLocker() {
        let param: [String: Any] = [
            "healthLockerFileRequestDTOS": [
                [
                  "fileSize": 0,
                  "fileType": "string",
                  "fileUri": "string"
                ]
              ],
              "hospitalName": "string",
              "name": "string",
              "reportDate": "2022-02-01T13:40:40.513Z",
              "userReportTypeId": 0
        ]
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: "healthLocker", method: .post, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func searchHealthLocker() {
        let param: [String: Any] = [
            "hospitalName": "string",
             "name": "string",
             "status": ""
        ]
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: "healthLocker/search", method: .post, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getHealthLockerDetails(id: String) {
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: "healthLocker/details/\(id)", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getReportTypeDropDown() {
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: "healthLocker/reportType/active/minfetchUserReportTypeForDropDown", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
}

