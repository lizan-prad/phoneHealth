//
//  OnboardingCoordnator.swift
//  PhoneHealth
//
//  Created by Lizan on 03/03/2022.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = OnboardingViewController.instantiate()
        vc.viewModel = OnboardingViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
