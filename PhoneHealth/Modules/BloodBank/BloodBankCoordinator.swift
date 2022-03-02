//
//  BloodBankCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import UIKit

class BloodBankCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = BloodBankViewController.instantiate()
        vc.viewModel = BloodBankViewModel()
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
