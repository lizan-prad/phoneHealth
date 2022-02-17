//
//  ProfileConfirmationCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class ProfileConfirmationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: HealthProfileModel?

    init(navigationController: UINavigationController, model: HealthProfileModel?) {
        self.navigationController = navigationController
        self.model = model
    }

    func start() {
        let vc = HabitsViewController.instantiate()
        vc.viewModel = HabitsViewModel()
        vc.viewModel.model = self.model
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> HabitsViewController {
        let vc = HabitsViewController.instantiate()
        vc.viewModel = HabitsViewModel()
        return vc
    }
}
