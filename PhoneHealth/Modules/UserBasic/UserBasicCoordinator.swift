//
//  UserBasicCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserBasicCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = UserBasicViewController.instantiate()
        vc.viewModel = UserBasicViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserBasicViewController {
        let vc = UserBasicViewController.instantiate()
        vc.viewModel = UserBasicViewModel()
        return vc
    }
}
