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
    var showAllergies = true {
        didSet {
            self.tableView.reloadData()
        }
    }
    var showDiseases = true {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        fetchProfile()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "edit"), style: .done, target: self, action: #selector(editOption))
        
        tableView.register(UINib.init(nibName: "FamilyHealthAllergiesTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyHealthAllergiesTableViewCell")
        tableView.register(UINib.init(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
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
        self.tabBarController?.tabBar.isHidden = false
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
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
        case 2,3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyHealthAllergiesTableViewCell") as! FamilyHealthAllergiesTableViewCell
            cell.allergiesLabel.text = indexPath.section == 2 ? "- \(self.model?.userAllergyInfo?.compactMap({$0.allergyName}).joined(separator: "\n- ") ?? "")" : "- \(self.model?.userDiseaseInfo?.compactMap({$0.diseaseName}).joined(separator: "\n- ") ?? "")"
            cell.section = indexPath.section
            cell.setup()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2,3:
            return 50
        default:
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 || section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! ProfileHeaderTableViewCell
            cell.headerTitleLabel.text = section == 2 ? "Allergies" : "Chronic Diseases"
            cell.setup()
            cell.showing = section == 2 ? showAllergies : showDiseases
            cell.section = section
            cell.didTap = { s, status in
                if s == 2 {
                    self.showAllergies = status
                } else {
                    self.showDiseases = status
                }
            }
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 194
        case 1:
            return 133
        case 2:
            return self.showAllergies ? UITableView.automaticDimension : 0
        case 3:
            return self.showDiseases ? UITableView.automaticDimension : 0
        default:
            return 0
        }
       
    }
}
