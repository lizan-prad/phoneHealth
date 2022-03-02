//
//  AmbulanceCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 24/02/2022.
//

import UIKit

class AmbulanceCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AmbulanceViewController.instantiate()
        vc.viewModel = AmbulanceViewModel()
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
