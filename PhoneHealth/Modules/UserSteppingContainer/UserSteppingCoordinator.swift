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
    var userProfModel: UserProfileModel?

    init(navigationController: UINavigationController, model: UpdateProfileStruct, usModel: UserProfileModel?) {
        self.navigationController = navigationController
        self.model = model
        self.userProfModel = usModel
    }

    func start() {
        let vc = UserSteppingConatinerViewController.instantiate()
        vc.viewModel = UserSteppingViewModel()
        vc.viewModel.updateProfileDetails = self.model
        vc.viewModel.userProfModel = self.userProfModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserSteppingConatinerViewController {
        let vc = UserSteppingConatinerViewController.instantiate()
        vc.viewModel = UserSteppingViewModel()
        return vc
    }
}
