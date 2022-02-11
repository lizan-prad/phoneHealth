//
//  HealthLockerListCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HealthLockerListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HealthLockerListViewController.instantiate()
        vc.viewModel = HealthLockerListViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
