//
//  ConnectHospitalCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//


import UIKit

class ConnectHospitalCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ConnectHospitalViewController.instantiate()
        vc.viewModel = ConnectHospitalViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
