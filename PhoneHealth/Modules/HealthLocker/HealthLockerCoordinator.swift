//
//  HealthLockerCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 11/02/2022.
//

import UIKit

class HealthLockerCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HealthLockerViewController.instantiate()
        vc.viewModel = HealthLockerViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> HealthLockerViewController {
        let vc = HealthLockerViewController.instantiate()
        vc.viewModel = HealthLockerViewModel()
        return vc
    }
}

