//
//  ProfileConfirmationCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class ProfileConfirmationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: HealthProfileModel?
    var updateProfileDetails: UpdateProfileStruct?

    init(navigationController: UINavigationController, model: HealthProfileModel?, userDetails: UpdateProfileStruct?) {
        self.navigationController = navigationController
        self.model = model
        self.updateProfileDetails = userDetails
    }

    func start() {
        let vc = ProfileConfirmationViewController.instantiate()
        vc.viewModel = ProfileConfirmationViewModel()
        vc.viewModel.model = self.model
        vc.viewModel.updateProfile = self.updateProfileDetails
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
