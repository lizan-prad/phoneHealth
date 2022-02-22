//
//  EappointmentsViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit
import Lottie

class EappointmentsViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "E-Appointments"
        animationView.loopMode = .loop
        animationView.backgroundColor = UIColor.init(hex: "F5FAFA")
        animationView.animationSpeed = 1
        animationView.play()
        // Do any additional setup after loading the view.
    }

}
