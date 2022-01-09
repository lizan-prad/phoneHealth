//
//  LoginCoodinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LoginViewController.instantiate()
        vc.viewModel = LoginViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
