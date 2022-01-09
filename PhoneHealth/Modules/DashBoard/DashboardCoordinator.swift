//
//  DashboardCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//
import UIKit

class DashboardCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = DashboardViewController.instantiate()
        vc.viewModel = DashboardViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> DashboardViewController {
        let vc = DashboardViewController.instantiate()
        vc.viewModel = DashboardViewModel()
        return vc
    }
}
