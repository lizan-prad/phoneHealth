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

class EappointmentsViewController: UIViewController, CogentPaymentDelegate {
//    func onCogentPaymentSuccess(info: [String : Any]) {
//        print(info)
//    }
//
//    func onCogentPaymentError(errorDescription: String) {
//        print(errorDescription)
//    }

    
    @IBOutlet weak var animationView: AnimationView!
    
    var userKYCModel: UserKYCModel?
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animationView.play()
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func openSDK() {
        self.userKYCModel = UserKYCModel(id: "9845528933", mobileNumber: "9845528933", dob: "1995-07-20", name: "Rupak Chaulagain", emailID: "awsdjda@gmail.com", gender: "M")
        
        // Do any additional setup after loading the view.
#if PRODUCTION
        self.cogentSDK = CogentLandingPagePresenter(delegate: self)
        // licenseString = EsewaCode.licenseStringRelease
#else
        self.cogentSDK = CogentLandingPagePresenter(delegate: self, esewaID: "9845528933", userKYCModel: self.userKYCModel!, colorTheme: UIColor.green)
#endif
        
        self.cogentSDK?.initiateLicenseValidation(licenseString: "", fromVC: self, shouldPresent: false)
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
        
        print("SDK Payment Success: \(info)")
    }
    
    func onCogentPaymentSuccess(info: [String : Any]) {
        print(info)
    }
    
    func onCogentPaymentError(errorDescription: String) {
    }

}
