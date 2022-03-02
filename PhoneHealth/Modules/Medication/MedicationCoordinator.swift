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
    var model: MedicationAlertModel?
    var isfromNotif: Bool?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MedicationViewController.instantiate()
        vc.viewModel = MedicationViewModel()
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.isFromNotif = isfromNotif ?? false
        vc.viewModel.model = model
        navigationController.pushViewController(vc, animated: true)
    }
    
}
