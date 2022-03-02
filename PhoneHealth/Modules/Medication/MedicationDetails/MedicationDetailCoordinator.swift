//
//  MedicationDetailCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import UIKit

class MedicationDetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var model: MedicationAlertModel
    var isFromNotif: Bool
    init(navigationController: UINavigationController, model: MedicationAlertModel, isFromNotif: Bool) {
        self.navigationController = navigationController
        self.model = model
        self.isFromNotif = isFromNotif
    }

    func start() {
        let vc = MedicationDetailViewController.instantiate()
        vc.viewModel = MedicationDetailViewModel(model: model)
        vc.isFromNotif = isFromNotif
        navigationController.present(vc, animated: true, completion: nil)
    }
    
}
