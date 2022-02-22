//
//  HealthLockerViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 11/02/2022.
//

import Foundation
import Alamofire

struct HealthLockerViewModel {
    
    var reportType: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var success: Observable<String> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func addHealthLocker(fileUri: String, fileType: StringLiteralType, fileSize: Int, hospitalName: String, name: String, reportDate: String, reportId: Int) {
        let param: [String: Any] = [
            "healthLockerFileRequestDTOS": [
                [
                  "fileSize": fileSize,
                  "fileType": fileType,
                  "fileUri": fileUri
                ]
              ],
              "hospitalName": hospitalName,
              "name": name,
              "reportDate": reportDate,
              "reportTypeId": reportId
        ]
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: URLConfig.baseUrl + "healthLocker", method: .post, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.success.value = model.responseStatus
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func getHealthLockerDetails(id: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<OtpModel>.self, urlExt: "healthLocker/details/\(id)", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getReportTypeDropDown() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "healthLocker/reportType/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.reportType.value = model.data?.dataList
                
            case .failure(let error):
                self.error.value = error
                
            }
        }
    }
    
}

