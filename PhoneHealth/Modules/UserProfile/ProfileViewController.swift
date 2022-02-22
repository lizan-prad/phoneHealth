//
//  ProfileViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model: UserProfileModel? {
        didSet {
            tableView.reloadData()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchProfile()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "edit"), style: .done, target: self, action: #selector(editOption))
        
        tableView.register(UINib.init(nibName: "UserBasicInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserBasicInfoTableViewCell")
        tableView.register(UINib.init(nibName: "ProfileCardTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileCardTableViewCell")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Profile"
        self.fetchProfile()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func editOption() {
        guard let navigationController = self.navigationController else {return}
        let coodinator = UpdateProfileCoordinator.init(navigationController: navigationController, user: self.model)
        coodinator.start()
    }
    
    func fetchProfile() {
        self.showProgressHud()
        NetworkManager.shared.request(BaseMappableModel<UserProfileContainerModel>.self, urlExt: URLConfig.baseUrl + "user/profile/details", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.hideProgressHud()
            switch result {
            case .success(let model):
                self.model = model.data?.userProfileDetail
                
            case .failure(let error):
                self.showAlert(title: nil, message: error.localizedDescription) { _ in
                    
                }
            }
        }
        
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCardTableViewCell") as! ProfileCardTableViewCell
            cell.model = self.model
            cell.setup()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserBasicInfoTableViewCell") as! UserBasicInfoTableViewCell
            cell.setup()
            cell.model = self.model
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 194
        }
        return 133
    }
}
