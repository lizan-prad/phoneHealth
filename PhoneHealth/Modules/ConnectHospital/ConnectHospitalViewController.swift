//
//  ConnectHospitalViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class ConnectHospitalViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ConnectHospitalViewModel()
    
    var hospitals: [HospitalListModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
  
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabbar()
        self.navigationItem.title = "Connect Hospital"
        self.viewModel.fetchHospitals()
        self.tabBarController?.tabBar.isHidden = false
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    func bindViewModel() {
        viewModel.hospitals.bind { models in
            self.hospitals = models
        }
        
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    

}

extension ConnectHospitalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectHospitalTableViewCell") as! ConnectHospitalTableViewCell
        cell.setup()
        cell.model = hospitals?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectHospitalHeaderTableViewCell") as! ConnectHospitalHeaderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nav = self.navigationController, let model = hospitals?[indexPath.row] else {return}
        let coordinator = AddConnectHospitalCoordinator.init(navigationController: nav, model: model)
        coordinator.start()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
