//
//  HabitsViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 13/01/2022.
//

import Foundation
import Alamofire

struct HabitsViewModel {
    
    var model: HealthProfileModel?
    var foodType: Observable<[DynamicUserDataModel]> = Observable([])
    var error: Observable<Error> = Observable(nil)
    
    func fetchFoodType() {
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "health/foodType/active/min", method: .get, param: nil, encoding: URLEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.foodType.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func getHealthParam() -> [String: Any] {
        let param: [String: Any] = [
            "alcoholFrequency": model?.alcoholFrequency ?? "",
            "bloodGroupId": model?.bloodGroupId ?? 0,
            "doYouDrinkAlcohol": model?.doYouDrinkAlcohol ?? "",
            "doYouSmoke": model?.doYouSmoke ?? "",
            "foodTypeId": model?.foodTypeId ?? 0,
            "haveAllergies": model?.haveAllergies ?? "",
            "haveCronicDisease": model?.haveCronicDease ?? "",
            "height": model?.height ?? "",
            "junkFoodFrequency": model?.junkFoodFrequency ?? "",
            "smokeFrequency": model?.smokeFrequency ?? "",
              "userAllergyInfoDetail": getAllergyParam(),
              "userDiseaseInfoDetail": getDiseaseParam(),
            "weight": model?.weight ?? ""
            ]
        return param
    }
    
    func getAllergyParam() -> [[String:Any]] {
        let param: [[String: Any]] = self.model?.userAllergyInfo?.map({[
            "allergyId": $0.allergyId ?? 0,
            "allergyName": $0.allergyName ?? "",
            "isPrimary": "N",
            "status": "N"
        ]}) ?? [[String:Any]]()
        return param
    }
    
    func getDiseaseParam() -> [[String:Any]] {
        let param: [[String: Any]] = self.model?.userDiseaseInfo?.map({[
            "diseaseId": $0.diseaseId ?? 0,
            "diseaseName": $0.diseaseName ?? "",
            "isPrimary": "N",
            "status": "N"
        ]}) ?? [[String:Any]]()
        return param
    }
    
    func uploadUserHealthData() {
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "user/profile/health/update", method: .put, param: self.getHealthParam(), encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.foodType.value = model.data?.dataList
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
