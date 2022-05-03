//
//  UserAllergyCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserAllergyCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var usModel: UserProfileModel?
    
    init(navigationController: UINavigationController, usModel: UserProfileModel? = nil) {
        self.navigationController = navigationController
        self.usModel = usModel
    }

    func start() {
        let vc = UserAlleryViewController.instantiate()
        vc.viewModel = UserAllergyViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> UserAlleryViewController {
        let vc = UserAlleryViewController.instantiate()
        vc.viewModel = UserAllergyViewModel()
        vc.viewModel.usModel = self.usModel
        return vc
    }
}
