//
//  FamilyProfile2Coordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 27/02/2022.
//

import UIKit

class AddFamilyProfile2Coordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: HealthProfileModel?
    
    var updateProfile: UserProfileModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AddFamilyProfile2ViewController.instantiate()
        vc.viewModel = AddFamilyProfile2ViewModel()
        vc.viewModel.model = self.model
        vc.model = self.updateProfile
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
