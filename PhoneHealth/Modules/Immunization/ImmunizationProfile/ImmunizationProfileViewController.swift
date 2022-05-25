//
//  ImmunizationProfileViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import UIKit

class ImmunizationProfileViewController: UIViewController, Storyboarded {

    @IBOutlet weak var addBtn: UIButton!
    var viewModel: ImmunizationProfileViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var models: [ImmunizationProfileModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtn.rounded()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "ImmunizationProfielTableViewCell", bundle: nil), forCellReuseIdentifier: "ImmunizationProfielTableViewCell")
        tableView.register(UINib.init(nibName: "RightLayoutPlaceholderTableViewCell", bundle: nil), forCellReuseIdentifier: "RightLayoutPlaceholderTableViewCell")

        
        viewModel.models.bind { models in
            self.models = models
        }
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        
        viewModel.loading.bind { status in
            status ?? false ? self.showProgressHud() : self.hideProgressHud()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Immunization Profile"
        viewModel.fetchImmunizationList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    @IBAction func addaction(_ sender: Any) {
        guard let nav = self.navigationController else {return}
        let coordinator = AddFamilyProfileCoordinator.init(navigationController: nav)
        coordinator.isChild = true
        coordinator.start()
    }
    
}

extension ImmunizationProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (models?.count == 0 || models?.count == nil)  ? 1 : models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if models?.count == 0 || models?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightLayoutPlaceholderTableViewCell") as! RightLayoutPlaceholderTableViewCell
            cell.setup()
            cell.infoText.text = "A personal health profile for each of your family members"
            cell.proceedBtn.setAttributedTitle("Add Family Profile".getAtrribText(), for: .normal)
            cell.placeholderImage.image = UIImage.init(named: "Family-Profile-Dashboard")
            cell.didTapProceed = {
                guard let nav = self.navigationController else {return}
                let coordinator = AddFamilyProfileCoordinator.init(navigationController: nav)
                coordinator.isChild = true
                coordinator.start()
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImmunizationProfielTableViewCell") as! ImmunizationProfielTableViewCell
        cell.setup()
        cell.model = self.models?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (models?.count == 0 || models?.count == nil) ? 190 : 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nav = self.navigationController else {return}
        let coordinator = ImmunizationCoordinator.init(navigationController: nav)
        coordinator.model = self.models?[indexPath.row]
        coordinator.start()
    }
}
