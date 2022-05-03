//
//  AddFamilyProfileCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 27/02/2022.
//

import UIKit

class AddFamilyProfileCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var isChild = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AddFamilyProfileViewController.instantiate()
        vc.viewModel = AddFamilyProfileViewModel()
        vc.isChild = self.isChild
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
