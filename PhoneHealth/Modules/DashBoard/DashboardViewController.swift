//
//  DashboardViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit
import WeScan
import Alamofire

class DashboardViewController: UIViewController, Storyboarded, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var greetLabel: UILabel!
    @IBOutlet weak var dropIcon: UIButton!
    @IBOutlet weak var notifIcon: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DashboardViewModel!
    var model: UserProfileModel? {
        didSet {
            self.profileImage.rounded()
            self.profileImage.sd_setImage(with: URL.init(string: model?.avatar ?? "")) { img,_,_,_ in
                self.profileImage.image = img?.rotateImage()
            }
        }
    }
    
    var emergencies: [ServiceModel] = [ServiceModel.init(image: "ambulance_ic", name: "Ambulance"), ServiceModel.init(image: "bloodbank", name: "Blood banks"), ServiceModel.init(image: "hospital_ic", name: "Hospitals")]
    
    var services: [ServiceModel] = [ServiceModel.init(image: "healthLocker", name: "Health Locker"), ServiceModel.init(image: "eappointments", name: "E Appointments"), ServiceModel.init(image: "medication", name: "Medication")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.imageInsets = UIEdgeInsets.init(top: 16, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        fetchProfile()
        dropIcon.setTitle("", for: .normal)
        notifIcon.setTitle("", for: .normal)
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        // Do any additional setup after loading the view.
    }
    
    func fetchProfile() {
        
        NetworkManager.shared.request(BaseMappableModel<UserProfileContainerModel>.self, urlExt: URLConfig.baseUrl + "user/profile/details", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let model):
                self.model = model.data?.userProfileDetail
                
            case .failure(let error):
                self.showAlert(title: nil, message: error.localizedDescription) { _ in
                    
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.showTabbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 203
        case 1:
            return 110
        case 2:
            return 110
        case 3:
            return 141
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell") as! AppointmentTableViewCell
            cell.setup()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell") as! ServicesTableViewCell
            cell.setup()
            cell.services = self.emergencies
            cell.didSelectLocker = {
                print("ambulance")
            }
            
            cell.didSelectMedication = {
                print("hospitals")
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell") as! ServicesTableViewCell
            cell.setup()
            cell.services = self.services
            cell.didSelectLocker = {
                guard let nav = self.navigationController else {return}
                let coordinator = HealthLockerListCoordinator.init(navigationController: nav)
                coordinator.start()
            }
            
            cell.didSelectMedication = {
                guard let nav = self.navigationController else {return}
                let coordinator = MedicationCoordinator.init(navigationController: nav)
                coordinator.start()
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalsTableViewCell") as! HospitalsTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 1:
            return 20
        case 2:
            return 20
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardHeaderTableViewCell") as! DashboardHeaderTableViewCell
        switch section {
        case 0:
            cell.headerLabel.text = "Your Appointments"
        case 1:
            cell.headerLabel.text = "Emergencies"
        case 2:
            cell.headerLabel.text = "Services"
        default:
            cell.headerLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            guard let nav = self.navigationController else {return}
            let coordinator = HospitalCardCoordinator.init(navigationController: nav, model: nil)
            coordinator.start()
        }
        
    }
    
}
