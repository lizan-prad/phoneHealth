//
//  UserSteppingCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserSteppingCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = UserSteppingConatinerViewController.instantiate()
        vc.viewModel = UserSteppingViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserSteppingConatinerViewController {
        let vc = UserSteppingConatinerViewController.instantiate()
        vc.viewModel = UserSteppingViewModel()
        return vc
    }
}
