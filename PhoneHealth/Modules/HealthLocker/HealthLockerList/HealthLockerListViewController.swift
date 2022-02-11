//
//  HealthLockerListViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HealthLockerListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var filterTextLabel: UILabel!
    @IBOutlet weak var fliterListSection: NSLayoutConstraint!
    @IBOutlet weak var addFilterStack: UIStackView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    var viewModel: HealthLockerListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setup() {
        addFilterStack.layer.cornerRadius = 16
        filterTextLabel.rounded()
        closeBtn.setTitle("", for: .normal)
        addBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
    }
    


}

extension HealthLockerListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthLockerListTableViewCell") as! HealthLockerListTableViewCell
        cell.setup()
        return cell
    }
}
