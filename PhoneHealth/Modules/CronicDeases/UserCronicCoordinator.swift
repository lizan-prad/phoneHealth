//
//  UserCronicCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserCronicCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var usModel: UserProfileModel?

    init(navigationController: UINavigationController, usModel: UserProfileModel? = nil) {
        self.navigationController = navigationController
        self.usModel = usModel
    }

    func start() {
        let vc = UserCronicViewController.instantiate()
        vc.viewModel = UserCronicViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserCronicViewController {
        let vc = UserCronicViewController.instantiate()
        vc.viewModel = UserCronicViewModel()
        vc.viewModel.usModel = usModel
        return vc
    }
}
