//
//  EappointmentsViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit
import Lottie
import CogentIOSFramework
import UI
import ObjectMapper
import EsewaSDK
import Alamofire

class EappointmentsViewController: UIViewController, CogentPaymentDelegate, EsewaSDKPaymentDelegate {
//    func onCogentPaymentSuccess(info: [String : Any]) {
//        print(info)
//    }
//
//    func onCogentPaymentError(errorDescription: String) {
//        print(errorDescription)
//    }
    @IBOutlet weak var childView: UIView!
    var sdk: EsewaSDK?
    
    @IBOutlet weak var animationView: AnimationView!
    
    var userKYCModel: UserKYCModel?
    
    var model: EAppointmentModel?
    
    var userModel: UserProfileModel?
    
    var cogentSDK: CogentLandingPagePresenter?
//    var cogentPresenter: CogentLandingPagePresenter?
//    var airlines: CogentLandingPagePresenter?
//    var userKYCModel: UserKYCModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "E-Appointments"
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "F5FAFA")
        animationView.animationSpeed = 1
        
        openSDK()
        fetchProfile()
        
//        self.userKYCModel = UserKYCModel(id: "9845528933", mobileNumber: "9845528933", dob: "1995-07-20", name: "Rupak Chaulagain", emailID: "awsdjda@gmail.com", gender: "M")
//        self.airlines = CogentLandingPagePresenter(delegate: self, esewaID: "9845528933", userKYCModel: self.userKYCModel!, colorTheme: .grayishBlueNight)
//        self.airlines?.initiateLicenseValidation(licenseString: "", fromVC: self, shouldPresent: false)
//
//
//        self.cogentPresenter = CogentLandingPagePresenter(delegate: self)
////
////
//        self.cogentPresenter?.initiatePayment(fromVC: self, shouldPresent: false)
        // Do any additional setup after loading the view.
        
    }
    
    func fetchProfile() {
        self.showProgressHud()
        NetworkManager.shared.request(BaseMappableModel<UserProfileContainerModel>.self, urlExt: URLConfig.baseUrl + "user/profile/details", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.hideProgressHud()
            switch result {
            case .success(let model):
                
                self.userModel = model.data?.userProfileDetail
                
            case .failure(let error):
                self.showAlert(title: nil, message: error.localizedDescription) { _ in
                    
                }
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animationView.play()
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        let image = UIImage().imageWithColor(color: ColorConfig.baseColor)
        self.navigationController?.navigationBar.shadowImage = image
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        // Navigation Bar Color
        self.navigationController?.view.backgroundColor = ColorConfig.baseColor
        //self.navigationController?.navigationBar.tintColor = Theme.Color.primaryText
        self.navigationController?.navigationBar.barTintColor = .white
            //ThemeManager.Color.esewaMainColor
        
                    
        
        // Remove text in backbutton navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "ic_nav_back")
        //self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_nav_back")
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: ThemeManager.Font.medium16]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    func openSDK() {
        self.userKYCModel = UserKYCModel(id: "9818804126", mobileNumber: "9818804126", dob: "1995-09-18", name: "Lizan Pradhanang", emailID: "lizan.pra19@gmail.com", gender: "M")
        
        // Do any additional setup after loading the view.
#if PRODUCTION
        self.cogentSDK = CogentLandingPagePresenter(delegate: self)
        // licenseString = EsewaCode.licenseStringRelease
#else
        self.cogentSDK = CogentLandingPagePresenter(delegate: self, esewaID: "9845528933", userKYCModel: self.userKYCModel!, colorTheme: UIColor.green)
#endif
        
        self.cogentSDK?.initiateLicenseValidation(licenseString: "", fromVC: self, shouldPresent: false) { vc in
            self.childView.addChildViewController(vc, parentViewController: self)
        }
    }
//
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//
//        if #available(iOS 13.0, *) {
//            super.traitCollectionDidChange(previousTraitCollection)
//            let image = UIImage().imageWithColor(color: ThemeManager.Color.esewaMainColor)
//
//            self.navigationController?.navigationBar.shadowImage = image
//            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
//        }
//    }
    
    func onEsewaSDKPaymentError(errorDescription: String) {
        print("SDK ERROR: \(errorDescription)")
    }
    
    func onEsewaSDKPaymentSuccess(info: [String : Any]) {
        if let model = self.model {
            let requestByParam: [String: Any] = [
                "address": userModel?.districtName ?? "",
                "dateOfBirth": (userModel?.dateOfBirth ?? "") + " AD",
                "districtId": userModel?.districtId ?? 0,
                "email": userModel?.email ?? "",
              "esewaId": "9806800001",
                "gender": "M",
              "hospitalNumber": "",
              "isAgent": "N",
                "mobileNumber": (UserDefaults.standard.value(forKey: "Mobile") as? String) ?? "",
                "name": userModel?.name ?? "",
                "provinceId": userModel?.provinceId ?? 0,
                "vdcOrMunicipalityId": userModel?.vdcOrMunicipalityId ?? "",
                "wardNumber": userModel?.wardNumber ?? 0
            ]
            
            let requestForParam: [String: Any] = [
                "address": model.properties?.patientAddress ?? "",
              "dateOfBirth": model.properties?.dateOfBirth?.replacingOccurrences(of: "BS", with: " AD") ?? "",
              "districtId": 12,
              "email": model.properties?.patientEmail ?? "",
              "esewaId": "9806800001",
              "gender": "M",
              "hospitalNumber": "",
              "mobileNumber": model.properties?.patientMobileNumber ?? "",
              "name": model.properties?.patientName ?? "",
              "provinceId": userModel?.provinceId ?? 0,
              "vdcOrMunicipalityId": userModel?.vdcOrMunicipalityId ?? "",
              "wardNumber": userModel?.wardNumber ?? 0
            ]
            
            let appointmentInfo: [String: Any] = [
                "appointmentReservationId": model.properties?.appointmentReservationId ?? 0,
                "createdDateNepali": model.properties?.createdDateNepali ?? "",
                "hospitalAppointmentServiceTypeId": model.properties?.hospitalAppointmentServiceTypeId ?? 0,
                "isFollowUp": model.properties?.followUp ?? "",
                "isNewRegistration": model.properties?.newRegistration ?? false,
                "parentAppointmentId": model.properties?.parentAppointmentId ?? "",
                "patientId": model.properties?.patientId ?? ""
            ]
            let formatter = DateFormatter()
            formatter.dateFormat = "ddd mmm dd HH:mm:ss zzz yyyy"
            let date = (info["transactionDetails"] as? [String: Any])?["date"] as! String
            let formatted = formatter.date(from: date)
            formatter.dateFormat = "yyyy-MM-dd"
            
            let transactionInfo: [String: Any] = [
                "appointmentAmount": model.amount ?? 0,
              "appointmentModeCode": "foneHealth",
                "discountAmount": 0,
                "serviceChargeAmount": 0,
              "taxAmount": 0,
                "transactionDate": formatter.string(from: Date()),
              "transactionNumber": (info["transactionDetails"] as? [String: Any])?["referenceId"] as! String
            ]
            
            
            let param: [String: Any] = [
            "appointmentInfo": appointmentInfo,
            "requestBy": requestByParam,
            "requestFor": requestForParam,
            "transactionInfo": transactionInfo
          ]
            self.finalPaymentProcess(param: param)
        }

    }
    
    func onCogentPaymentSuccess(info: [String : Any]) {
        if let model = Mapper<EAppointmentModel>().map(JSON: info) {
            
            self.model = model
            self.prePaymentProcess(param: ["esewaMerchantCode": model.product_code ?? ""])
        }
    }
    
    func onCogentPaymentError(errorDescription: String) {
        
    }
    
    func openEsewaSDK(mode: EsewaModelMap) {
        
        
        sdk = EsewaSDK(inViewController: self, environment: .development, delegate: self)
        sdk?.initiatePayment(merchantId: mode.clientId ?? "", merchantSecret: mode.clientSecret ?? "", productName: "eappointment", productAmount: "\(Int(self.model?.amount ?? 0))", productId: "\(self.model?.product_code ?? "")", callbackUrl: "cashBack", paymentProperties: nil)
        
    }
    
    func finalPaymentProcess(param: [String:Any]) {
        self.showProgressHud()
        NetworkManager.shared.request(EsewaModelMap.self, urlExt: "https://uat-fonehealthapi.eappointments.net/api/v1/appointment/others", method: .post, param: param, encoding: JSONEncoding.default, headers: ["Authorization": "HmacSHA512 eSewa:057d470f-c6dc-4509-8a2c-670e9bbb1731:954145191157303:ky98M6rSqZ5KXaVZ5NEdcvh2CSwRVgCXcx18RmaVJ0huggvbVQ3+lJmKZKiZVvkEbElXUVGpOYX8nPnoH6ErQA=="]) { result in
            self.hideProgressHud()
            switch result {
            case .success(let model):
                self.showAlert(title: nil, message: "Appointment has be booked successfully.") { _ in
                    
                }
            case .failure(let error):
                self.showAlert(title: nil, message: error.localizedDescription) { _ in
                    
                }
            }
        }
    }
    
    func prePaymentProcess(param: [String:Any]) {
        NetworkManager.shared.request(EsewaModelMap.self, urlExt: URLConfig.baseUrl + "payment/detail", method: .put, param: param, encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.openEsewaSDK(mode: model)
            case .failure(let error):
                self.showAlert(title: nil, message: error.localizedDescription) { _ in
                    
                }
            }
        }
    }
    
    

}

class EsewaModelMap: Mappable {
    var clientId: String?
    var clientSecret: String?
    var merchantCode: String?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        merchantCode <- map["merchantCode"]
        clientSecret <- map["clientSecret"]
        clientId <- map["clientId"]
    }
}
