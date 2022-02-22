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
    var model: HospitalListModel
    var mobile: String
    var patientId: String
    var otp: String

    init(navigationController: UINavigationController, model: HospitalListModel, mobile: String, patientId: String, otp: String) {
        self.navigationController = navigationController
        self.model = model
        self.mobile = mobile
        self.patientId = patientId
        self.otp = otp
    }

    func start() {
        let vc = ConnectHospitalOtpViewController.instantiate()
        vc.viewModel = ConnectHospitalOtpViewModel(hospitalModel: model, mobile: mobile, patientId: patientId, otp: otp)
        navigationController.pushViewController(vc, animated: true)
    }
}
