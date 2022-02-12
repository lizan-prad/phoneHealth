//
//  MedicationCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//
import UIKit

class MedicationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MedicationViewController.instantiate()
        vc.viewModel = MedicationViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
