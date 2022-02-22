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
    var model: HospitalListModel?

    init(navigationController: UINavigationController, model: HospitalListModel?) {
        self.navigationController = navigationController
        self.model = model
    }

    func start() {
        let vc = HospitalCardViewController.instantiate()
        vc.viewModel = HospitalCardViewModel(hospitalModel: model)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}

