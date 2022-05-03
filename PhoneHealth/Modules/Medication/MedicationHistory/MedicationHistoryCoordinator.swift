//
//  MedicationHistoryCoordinator'.swift
//  PhoneHealth
//
//  Created by Lizan on 15/04/2022.
//

import UIKit

class MedicationHistoryCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MedicationHistoryViewController.instantiate()
        vc.viewModel = MedicationHistoryViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
