//
//  FamilyProfile2ViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 27/02/2022.
//

import Foundation
import Alamofire
struct AddFamilyProfile2ViewModel {
    
    var model: HealthProfileModel?
    var allergies: Observable<[DynamicUserDataModel]> = Observable([])
    var cronics: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func fetchAllergies() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "health/allergies/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.allergies.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchDiseases() {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "health/disease/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.cronics.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func getHealthParam() -> [String: Any] {
        let param: [String: Any] = [
            "alcoholFrequency": "",
            "bloodGroupId": model?.bloodGroupId ?? 0,
            "doYouDrinkAlcohol": "N",
            "doYouSmoke": "N",
            "foodTypeId": 0,
            "haveAllergies": model?.haveAllergies ?? "",
            "haveCronicDisease": model?.haveCronicDease ?? "",
            "height": model?.height ?? "",
            "junkFoodFrequency": "",
            "smokeFrequency": "",
              "userAllergyInfoDetail": getAllergyParam(),
              "userDiseaseInfoDetail": getDiseaseParam(),
            "userId": model?.userId ?? "",
            "weight": model?.weight ?? ""
            ]
        return param
    }
    
    func getAllergyParam() -> [[String:Any]] {
        let param: [[String: Any]] = self.model?.userAllergyInfo?.map({[
            "allergyId": $0.allergyId ?? 0,
            "allergyName": $0.allergyName ?? "",
            "isPrimary": "N",
            "status": "N",
            "userAllergyInfoId": $0.info ?? 0
        ]}) ?? [[String:Any]]()
        return param
    }
    
    func getDiseaseParam() -> [[String:Any]] {
        let param: [[String: Any]] = self.model?.userDiseaseInfo?.map({[
            "diseaseId": $0.diseaseId ?? 0,
            "diseaseName": $0.diseaseName ?? "",
            "isPrimary": "N",
            "status": "N",
            "userAllergyInfoId": $0.info ?? 0
        ]}) ?? [[String:Any]]()
        return param
    }
    
    func uploadUserHealthData() {
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "user-family/profile/health/update", method: .put, param: self.getHealthParam(), encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
               break
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
