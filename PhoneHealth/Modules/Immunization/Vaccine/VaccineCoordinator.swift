//
//  VaccineCoordinator.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import UIKit

class VaccineCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var model: [AvailableVaccineList]?
    var id: Int?
    var vaccineType: VaccineViewType?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = VaccineViewController.instantiate()
        vc.viewModel = VaccineViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getMainView() -> VaccineViewController {
        let vc = VaccineViewController.instantiate()
        vc.viewModel = VaccineViewModel()
        vc.childId = id
        vc.model = model
        vc.currentVaccineType = self.vaccineType
        return vc
    }
}
