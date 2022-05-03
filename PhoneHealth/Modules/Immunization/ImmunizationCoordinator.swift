//
//  ImmunizationCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 07/04/2022.
//
import UIKit

class ImmunizationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var model: ImmunizationProfileModel?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ImmunizationViewController.instantiate()
        vc.viewModel = ImmunizationViewModel()
        vc.viewModel.childModel = model
        navigationController.pushViewController(vc, animated: true)
    }
}
