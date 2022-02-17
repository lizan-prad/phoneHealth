//
//  HospitalCardCoordinatoer.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HospitalCardCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: DynamicUserDataModel

    init(navigationController: UINavigationController, model: DynamicUserDataModel) {
        self.navigationController = navigationController
        self.model = model
    }

    func start() {
        let vc = HospitalCardViewController.instantiate()
        vc.viewModel = HospitalCardViewModel(hospitalModel: model)
        navigationController.pushViewController(vc, animated: true)
    }
}

