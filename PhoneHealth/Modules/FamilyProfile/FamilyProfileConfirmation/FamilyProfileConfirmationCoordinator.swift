//
//  FamilyProfileConfirmationCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit

class FamilyProfileConfirmationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: HealthProfileModel?

    init(navigationController: UINavigationController, model: HealthProfileModel?) {
        self.navigationController = navigationController
        self.model = model
    }

    func start() {
        let vc = FamilyProfileConfirmationViewController.instantiate()
        vc.viewModel = FamilyProfileConfirmationViewModel()
        vc.viewModel.model = self.model
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
