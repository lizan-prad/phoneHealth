//
//  OtpCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class OtpCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var otpModel: OtpModel
    
    var isFromReset = false

    init(navigationController: UINavigationController, model: OtpModel) {
        self.navigationController = navigationController
        self.otpModel = model
    }

    func start() {
        let vc = OtpViewController.instantiate()
        vc.viewModel = OtpViewModel.init(model: self.otpModel)
        vc.isFromReset = true
        navigationController.pushViewController(vc, animated: true)
    }
}
