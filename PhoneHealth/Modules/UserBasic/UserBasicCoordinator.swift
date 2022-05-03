//
//  UserBasicCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserBasicCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var usModel: UserProfileModel?

    init(navigationController: UINavigationController, usModel: UserProfileModel? = nil) {
        self.navigationController = navigationController
        self.usModel = usModel
    }

    func start() {
        let vc = UserBasicViewController.instantiate()
        vc.viewModel = UserBasicViewModel()
//        vc.viewModel.model = self.usModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserBasicViewController {
        let vc = UserBasicViewController.instantiate()
        vc.viewModel = UserBasicViewModel()
        vc.viewModel.model = self.usModel
        return vc
    }
}
