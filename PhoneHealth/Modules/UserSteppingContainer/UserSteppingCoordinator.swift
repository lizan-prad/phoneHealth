//
//  UserSteppingCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserSteppingCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: UpdateProfileStruct?

    init(navigationController: UINavigationController, model: UpdateProfileStruct) {
        self.navigationController = navigationController
        self.model = model
    }

    func start() {
        let vc = UserSteppingConatinerViewController.instantiate()
        vc.viewModel = UserSteppingViewModel()
        vc.viewModel.updateProfileDetails = self.model
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserSteppingConatinerViewController {
        let vc = UserSteppingConatinerViewController.instantiate()
        vc.viewModel = UserSteppingViewModel()
        return vc
    }
}
