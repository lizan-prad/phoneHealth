//
//  AddMedicationCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import UIKit

class AddMedicationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AddMedicationViewController.instantiate()
        vc.viewModel = AddMedicationViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
