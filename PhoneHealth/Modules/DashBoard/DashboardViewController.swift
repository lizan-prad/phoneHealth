//
//  DashboardViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class DashboardViewController: UIViewController, Storyboarded, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 203
        case 1:
            return 139
        case 2:
            return 182
        case 3:
            return 141
        case 4:
            return 139
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmergenciesTableViewCell") as! EmergenciesTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell") as! ServicesTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationsTableViewCell") as! MedicationsTableViewCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalsTableViewCell") as! HospitalsTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }

}
