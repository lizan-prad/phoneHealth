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

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var greetLabel: UILabel!
    @IBOutlet weak var dropIcon: UIButton!
    @IBOutlet weak var notifIcon: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DashboardViewModel!
    var model: UserProfileModel? {
        didSet {
            self.userName.text = "Hi, " + (model?.name ?? "")
            self.profileImage.rounded()
            self.profileImage.sd_setImage(with: URL.init(string: model?.avatar ?? "")) { img,_,_,_ in
                if img?.imageOrientation != .up {
                self.profileImage.image = img?.rotateImage()
                }
            }
        }
    }
    var familyList: [FamilyProfileListModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var medicationList: [MedicationDataModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    var emergencies: [ServiceModel] = [ServiceModel.init(image: "ambulance_ic", name: "Ambulance"), ServiceModel.init(image: "bloodbank", name: "Blood banks"), ServiceModel.init(image: "hospital_ic", name: "Hospitals")]
    
    var services: [ServiceModel] = [ServiceModel.init(image: "healthLocker", name: "Health Locker"), ServiceModel.init(image: "eappointments", name: "E Appointments"), ServiceModel.init(image: "medication", name: "Medication"), ServiceModel.init(image: "activity", name: "Activity")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = DashboardViewModel()
        self.tabBarItem.imageInsets = UIEdgeInsets.init(top: 16, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "DashboardMedicationTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardMedicationTableViewCell")
        tableView.register(UINib.init(nibName: "DashboardFamilyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardFamilyProfileTableViewCell")
        
        tableView.register(UINib.init(nibName: "EmergenciesDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "EmergenciesDashboardTableViewCell")
        
        bindViewModel()
        dropIcon.setTitle("", for: .normal)
        notifIcon.setTitle("", for: .normal)
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        dropIcon.addTarget(self, action: #selector(openProfileEdit), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func openProfileEdit() {
        let alert = UIAlertController.init(title: nil, message: "Settings", preferredStyle: .actionSheet)
        let logout = UIAlertAction.init(title: "Log Out", style: .destructive) { _ in
            UserDefaults.standard.set(nil, forKey: "AT")
            UserDefaults.standard.set(nil, forKey: "Mobile")
            guard let nav = self.navigationController else {return}
            let coordinator = LoginCoordinator(navigationController: nav)
            appdelegate.window?.rootViewController =  UINavigationController.init(rootViewController: coordinator.getMainView())
        }
        let cancel = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        alert.addAction(logout)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func bindViewModel() {
        self.viewModel.families.bind { models in
            self.familyList = models
        }
        self.viewModel.medications.bind { models in
            self.medicationList = models
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
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
        self.viewModel.fetchMedication()
        self.viewModel.fetchFamily()
        self.fetchProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
            return 120
        case 4:
            return 120
        case 5:
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmergenciesDashboardTableViewCell") as! EmergenciesDashboardTableViewCell
            cell.setup()
            cell.setupView()
            cell.services = self.emergencies
            cell.didSelectLocker = {
                guard let nav = self.navigationController else {return}
                let coordinator = AmbulanceCoordinator.init(navigationController: nav)
                coordinator.start()
            }
            cell.didSelectEappointment = {
                guard let nav = self.navigationController else {return}
                let coordinator = BloodBankCoordinator.init(navigationController: nav)
                coordinator.start()
            }
            cell.didSelectMedication = {
                print("hospitals")
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell") as! ServicesTableViewCell
            cell.setup()
            cell.services = self.services
//            cell.setupView()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardMedicationTableViewCell") as! DashboardMedicationTableViewCell
            cell.setup()
            cell.medications = self.medicationList
            cell.didTapAdd = {
                guard let nav = self.navigationController else {return}
                let coordinator = MedicationCoordinator.init(navigationController: nav)
                coordinator.start()
            }
            cell.didTapOpen = { model in
                guard let nav = self.navigationController else {return}
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm:ss"
                let time = formatter.date(from: model?.time?.first?.time ?? "")
                formatter.dateFormat = "H:mm a"
                let coordinator = MedicationDetailCoordinator.init(navigationController: nav, model: MedicationAlertModel.init(time: formatter.string(from: time ?? Date()), numberOfPill: "\(model?.quantity ?? "")", id: "\(model?.medicationId ?? 0)-\(model?.time?.first?.id ?? 0)", title: model?.medicineName ?? ""), isFromNotif: false)
                coordinator.start()
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardFamilyProfileTableViewCell") as! DashboardFamilyProfileTableViewCell
            cell.setup()
            cell.setupCollection()
            cell.model = self.familyList
            cell.didTapAdd = {
                guard let nav = self.navigationController else {return}
                let coordinator = AddFamilyProfileCoordinator.init(navigationController: nav)
                coordinator.start()
            }
            cell.didSelectRow = { index in
                guard let nav = self.navigationController else {return}
                let coordinator = FamilyProfileDetailsCoordinator.init(navigationController: nav)
                coordinator.model = self.familyList?[index]
                coordinator.start()
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalsTableViewCell") as! HospitalsTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 25
        case 1:
            return 25
        case 2:
            return 25
        case 3:
            return 25
        case 4:
            return 25
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
            cell.headerLabel.text = "Our Services"
        case 3:
            cell.headerLabel.text = "Current Medications"
        case 4:
            cell.headerLabel.text = "Family Profiles"
        default:
            cell.headerLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            guard let nav = self.navigationController else {return}
            
            let coordinator = HospitalCardCoordinator.init(navigationController: nav, model: nil)
            coordinator.start()
        }
        
    }
    
}
