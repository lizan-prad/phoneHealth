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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
    
    func setupTableView() {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
