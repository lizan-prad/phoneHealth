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

    @IBOutlet weak var animationView: AnimationView!
//    var cogentPresenter: CogentLandingPagePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "E-Appointments"
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "F5FAFA")
        animationView.animationSpeed = 1
        animationView.play()
        
//
//
//        self.cogentPresenter = CogentLandingPagePresenter(delegate: self)
//
//
//        self.cogentPresenter?.initiatePayment(fromVC: self, shouldPresent: false)
        // Do any additional setup after loading the view.
    }

}
