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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AddFamilyProfile2ViewController.instantiate()
        vc.viewModel = AddFamilyProfile2ViewModel()
        vc.viewModel.model = self.model
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
