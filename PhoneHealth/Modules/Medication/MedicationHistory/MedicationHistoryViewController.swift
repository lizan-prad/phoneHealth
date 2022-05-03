//
//  MedicationHistoryViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 15/04/2022.
//

import UIKit

class MedicationHistoryViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: MedicationHistoryViewModel!
    
    var models: [MedicationHistoryDataModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Medication History"
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib.init(nibName: "MedicationHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicationHistoryTableViewCell")
        
        viewModel.fetchMedication()
        
        viewModel.medications.bind { models in
            self.models = models
        }
        viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
        // Do any additional setup after loading the view.
    }


}

extension MedicationHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationHistoryTableViewCell") as! MedicationHistoryTableViewCell
        cell.model = self.models?[indexPath.row]
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}


