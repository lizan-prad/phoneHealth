//
//  RegistrationCoodinator.swift
//  PhoneHealth
//
//  Created by Lizan on 06/01/2022.
//

import UIKit

class RegistrationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = RegistrationViewController.instantiate()
        vc.viewModel = RegistrationViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
