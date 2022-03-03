//
//  HospitalCardViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import Foundation
import Alamofire
import PDFKit

struct HospitalCardViewModel {
    
    var hospitalModel: HospitalListModel?
    var pdf: Observable<PDFDocument> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var model: Observable<HospitalListModel> = Observable(nil)
    
    func fetchHospitalDetail(id: String, patient: String) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<HospitalListContainerModel>.self, urlExt: URLConfig.baseUrl + "connect-hospital/hospital-detail", method: .put, param: ["hospitalId": id, "patientId": patient], encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.model.value = model.data?.hospital
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchReports() {
        self.loading.value = true
        NetworkManager.shared.requestData(urlExt:  URLConfig.baseUrl + "connect-hospital/lab-report", method: .put, param: ["hospitalId": "\(hospitalModel?.hospitalId ?? 0)", "patientId": hospitalModel?.patientId ?? ""], encoding: JSONEncoding.default, headers: nil) { data in
            self.loading.value = false
            let pdf = PDFDocument.init(data: data)
            self.pdf.value = pdf
        }
    }
}
