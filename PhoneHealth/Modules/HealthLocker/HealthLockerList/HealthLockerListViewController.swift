//
//  HealthLockerListViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HealthLockerListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var reportsHeader: UIView!
    @IBOutlet weak var filterContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var filterTextLabel: UILabel!
    @IBOutlet weak var fliterListSection: NSLayoutConstraint!
    @IBOutlet weak var addFilterStack: UIStackView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var reportsHeight: NSLayoutConstraint!
    
    var viewModel: HealthLockerListViewModel!
    var lockerList: [HealthLockerListModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Health Locker"
        self.hideTabbar()
        setup()
        reportsHeight.constant = 0
        bindViewModel()
        setupTableView()
        self.viewModel.searchHealthLocker()
        addBtn.addTarget(self, action: #selector(addHealthLockerAction), for: .touchUpInside)
    }
    
    func bindViewModel() {
        self.viewModel.models.bind { models in
            self.lockerList = models
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    @objc func addHealthLockerAction() {
        guard let nav = self.navigationController else {return}
        let coordinator = HealthLockerCoordinator.init(navigationController: nav)
        let vc = coordinator.getMainView()
        vc.callForRefresh = {
            self.viewModel.searchHealthLocker()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setup() {
        filterContainer.layer.cornerRadius = 27.5
        filterTextLabel.rounded()
        closeBtn.setTitle("", for: .normal)
        addBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
    }
    


}

extension HealthLockerListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lockerList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthLockerListTableViewCell") as! HealthLockerListTableViewCell
        cell.setup()
        cell.model = self.lockerList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Scan", bundle: nil).instantiateViewController(withIdentifier: "ScanViewController") as! ScanViewController
        vc.image = self.lockerList?[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
