//
//  SetPasswordCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//


import UIKit

class SetPasswordCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var isFromReset = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
      
    }

    func start() {
        let vc = SetPasswordViewController.instantiate()
        vc.viewModel = SetPasswordViewModel()
        vc.isFromReset = isFromReset
        navigationController.pushViewController(vc, animated: true)
    }
}
