//
//  ImmunizationProfileCoordfinator.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import UIKit

class ImmunizationProfileCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ImmunizationProfileViewController.instantiate()
        vc.viewModel = ImmunizationProfileViewModel()
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
