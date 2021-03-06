//
//  FamilyProfileConfirmationViewModel.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import Foundation
import Alamofire

struct FamilyProfileConfirmationViewModel {
    
    var model: HealthProfileModel?
    
    var error: Observable<Error> = Observable(nil)
    var success: Observable<String> = Observable(nil)
    var loading: Observable<Bool> = Observable(nil)
    
    func getHealthParam(userId: Int?) -> [String: Any] {
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
            "weight": model?.weight ?? "",
            "userId": userId == nil ? model?.userId ?? "" : userId ?? 0
            ]
        return param
    }
    
    func getAllergyParam() -> [[String:Any]] {
        let param: [[String: Any]] = self.model?.userAllergyInfo?.map({[
            "allergyId": $0.allergyId ?? 0,
            "allergyName": $0.allergyName ?? "",
            "isPrimary": $0.isPrimary ?? "N",
            "status": $0.status ?? "N",
            "userAllergyInfoId": $0.info ?? 0
        ]}) ?? [[String:Any]]()
        return param
    }
    
    func getDiseaseParam() -> [[String:Any]] {
        let param: [[String: Any]] = self.model?.userDiseaseInfo?.map({[
            "diseaseId": $0.diseaseId ?? 0,
            "diseaseName": $0.diseaseName ?? "",
            "isPrimary": $0.isPrimary ?? "N",
            "status": $0.status ?? "N",
            "userDiseaseInfoId": $0.info ?? 0
        ]}) ?? [[String:Any]]()
        return param
    }
    
    func uploadFamilyHealth(userId: Int?) {
        self.loading.value = true
        NetworkManager.shared.request(BaseMappableModel<DynamicUserDataListModel>.self, urlExt: URLConfig.baseUrl + "user-family/profile/health/update", method: .put, param: self.getHealthParam(userId: userId), encoding: JSONEncoding.default, headers: nil) { result in
            self.loading.value = false
            switch result {
            case .success(let model):
                self.success.value = model.responseStatus
            case .failure(let error):
                self.error.value = error
            }
        }
    }

}
