//
//  HabitsCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 13/01/2022.
//

import UIKit

class HabitsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HabitsViewController.instantiate()
        vc.viewModel = HabitsViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> HabitsViewController {
        let vc = HabitsViewController.instantiate()
        vc.viewModel = HabitsViewModel()
        return vc
    }
}
