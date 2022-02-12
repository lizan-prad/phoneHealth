//
//  MedicationListViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import UIKit

class MedicationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    var didTapAdd: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCells()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupViews() {
        addBtn.rounded()
    }
    
    func setupCells() {
        tableView.register(UINib.init(nibName: "MedicationListTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicationListTableViewCell")
    }
    
    @IBAction func addAction(_ sender: Any) {
        didTapAdd?()
    }
    
}

extension MedicationListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationListTableViewCell") as! MedicationListTableViewCell
        return cell
    }
}
