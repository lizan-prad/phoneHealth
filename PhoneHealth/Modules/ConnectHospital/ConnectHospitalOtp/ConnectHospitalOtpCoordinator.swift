//
//  ConnectHospitalOtpCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 17/02/2022.
//

import UIKit

class ConnectHospitalOtpCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: DynamicUserDataModel
    var mobile: String
    var patientId: String

    init(navigationController: UINavigationController, model: DynamicUserDataModel, mobile: String, patientId: String) {
        self.navigationController = navigationController
        self.model = model
        self.mobile = mobile
        self.patientId = patientId
    }

    func start() {
        let vc = ConnectHospitalOtpViewController.instantiate()
        vc.viewModel = ConnectHospitalOtpViewModel(hospitalModel: model, mobile: mobile, patientId: patientId)
        navigationController.pushViewController(vc, animated: true)
    }
}
