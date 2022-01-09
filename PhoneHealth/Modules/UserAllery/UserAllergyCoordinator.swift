//
//  UserAllergyCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserAllergyCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = UserAlleryViewController.instantiate()
        vc.viewModel = UserAllergyViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserAlleryViewController {
        let vc = UserAlleryViewController.instantiate()
        vc.viewModel = UserAllergyViewModel()
        return vc
    }
}
