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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = OtpViewController.instantiate()
        vc.viewModel = OtpViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
