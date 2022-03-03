//
//  UpdatePasswordCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UpdateProfileCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: UserProfileModel?
    
    init(navigationController: UINavigationController, user: UserProfileModel?) {
        self.navigationController = navigationController
        self.model = user
    }

    func start() {
        let vc = UpdateProfileViewController.instantiate()
        var viewModel = UpdateProfileViewModel()
        viewModel.model = self.model
        vc.viewModel = viewModel

            vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
