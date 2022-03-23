//
//  ImmunizationCalendarCoodinator.swift
//  PhoneHealth
//
//  Created by Lizan on 20/03/2022.
//

import UIKit

class ImmunizationCalendarCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ImmunizationCalendarViewController.instantiate()
        vc.viewModel = ImmunizationCalendarViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> ImmunizationCalendarViewController {
        let vc = ImmunizationCalendarViewController.instantiate()
        vc.viewModel = ImmunizationCalendarViewModel()
        return vc
    }
    
}
