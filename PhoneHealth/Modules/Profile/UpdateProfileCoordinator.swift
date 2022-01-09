//
//  UpdatePasswordCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UpdateProfileCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = UpdateProfileViewController.instantiate()
        vc.viewModel = UpdateProfileViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
