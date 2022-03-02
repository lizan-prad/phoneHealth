//
//  FamilyProfileDetailsCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit

class FamilyProfileDetailsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: FamilyProfileListModel?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = FamilyProfileDetailsViewController.instantiate()
        vc.viewModel = FamilyProfileDetailsViewModel()
        vc.viewModel.model = model
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}
