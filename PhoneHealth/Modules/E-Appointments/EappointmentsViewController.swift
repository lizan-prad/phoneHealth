//
//  EappointmentsViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit
import Lottie
//import CogentIOSFramework

class EappointmentsViewController: UIViewController {
//    func onCogentPaymentSuccess(info: [String : Any]) {
//        print(info)
//    }
//
//    func onCogentPaymentError(errorDescription: String) {
//        print(errorDescription)
//    }
    

    @IBOutlet weak var animationView: AnimationView!
//    var cogentPresenter: CogentLandingPagePresenter?
//    var airlines: CogentLandingPagePresenter?
//    var userKYCModel: UserKYCModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "E-Appointments"
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "F5FAFA")
        animationView.animationSpeed = 1
        animationView.play()
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

}
