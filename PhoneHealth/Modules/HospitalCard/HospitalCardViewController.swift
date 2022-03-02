//
//  HospitalCardViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HospitalCardViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HospitalCardViewModel!
    var model: HospitalListModel? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        bindViewModel()
        self.viewModel.fetchHospitalDetail()
        self.navigationItem.title = "Chirayu Hospital"
    }
    
    func bindViewModel() {
        self.viewModel.model.bind { model in
            self.model = model
        }
        self.viewModel.loading.bind { status in
            if status ?? false {self.showProgressHud()} else {self.hideProgressHud()}
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
    }
    
    func setupTableView() {
        self.hideTabbar()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViews() {
        tableView.register(UINib.init(nibName: "HospitalCardReportsTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalCardReportsTableViewCell")
        tableView.register(UINib.init(nibName: "HospitalCardAppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalCardAppointmentTableViewCell")
        tableView.register(UINib.init(nibName: "HospitalCardLastCheckUpTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalCardLastCheckUpTableViewCell")
        tableView.register(UINib.init(nibName: "HospitalCardNoticeTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalCardNoticeTableViewCell")
        tableView.register(UINib.init(nibName: "HospitalCardDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalCardDetailsTableViewCell")
    }

}

extension HospitalCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 181
        case 1:
            return 160
        case 2:
            return 70
        case 3:
            return 144
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCardDetailsTableViewCell") as! HospitalCardDetailsTableViewCell
            cell.container.addCornerRadius(12)
            cell.hospitalLogo.addCornerRadius(8)
            cell.container.addBorder(.lightGray.withAlphaComponent(0.3))
            cell.model = self.model
            cell.didTapAmbulance = { phone in
                guard let number = URL(string: "tel://" + (phone)) else { return }
                UIApplication.shared.open(number)
            }
            cell.didTapEmergency = { phone in
                guard let number = URL(string: "tel://" + (phone)) else { return }
                UIApplication.shared.open(number)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCardNoticeTableViewCell") as! HospitalCardNoticeTableViewCell
            cell.noticeCOnatiner.addCornerRadius(12)
            cell.noticeCOnatiner.setStandardShadow()
            cell.setup()
            cell.notices = model?.hospitalNoticeDetail
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCardAppointmentTableViewCell") as! HospitalCardAppointmentTableViewCell
            cell.mainCOntaienr.addCornerRadius(8)
            cell.logoContainer.rounded()
            cell.mainCOntaienr.setStandardShadow()
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCardLastCheckUpTableViewCell") as! HospitalCardLastCheckUpTableViewCell
            cell.mainContainer.addCornerRadius(12)
            cell.followUpBtn.rounded()
            cell.followUpBtn.setAttributedTitle("Free Followup".getAtrribText(), for: .normal)
            cell.mainContainer.setStandardShadow()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
