//
//  AddConnectHosiptalCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import UIKit

class AddConnectHospitalCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: HospitalListModel

    init(navigationController: UINavigationController, model: HospitalListModel) {
        self.navigationController = navigationController
        self.model = model
    }

    func start() {
        let vc = AddConnectHospitalViewController.instantiate()
        vc.viewModel = AddConnectHospitalViewModel(hospitalModel: model)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
