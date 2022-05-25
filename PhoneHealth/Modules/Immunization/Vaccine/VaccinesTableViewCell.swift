//
//  VaccinesTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 06/04/2022.
//

import UIKit

class VaccinesTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var vaccinationViewType: VaccineViewType?
    
    var didTapTake: ((AvailableVaccinesList?) -> ())?
    
    var model: AvailableVaccineList? {
        didSet {
            self.tableview.reloadData()
            sectionTitle.text = model?.title
            actionLabel.text = vaccinationViewType == .history ? "Date" : "Action"
            tableViewHeight.constant = CGFloat((model?.availableVaccinesList?.count ?? 0)*30)
        }
    }
    
    func setup() {
        
        container.setStandardShadow()
        container.addCornerRadius(12)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib.init(nibName: "VaccineListTableViewCell", bundle: nil), forCellReuseIdentifier: "VaccineListTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.availableVaccinesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VaccineListTableViewCell") as! VaccineListTableViewCell
        cell.setup()
        cell.takeBtn.isHidden = vaccinationViewType == .history
        cell.vaccineDate.isHidden = vaccinationViewType == .present
        cell.model = model?.availableVaccinesList?[indexPath.row]
        cell.didTapTake = { model in
            self.didTapTake?(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
