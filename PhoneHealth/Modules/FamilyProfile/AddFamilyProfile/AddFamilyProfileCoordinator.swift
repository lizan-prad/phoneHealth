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
    
    var userModel: UserProfileModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AddFamilyProfileViewController.instantiate()
        vc.viewModel = AddFamilyProfileViewModel()
        vc.isChild = self.isChild
        vc.model = userModel
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
