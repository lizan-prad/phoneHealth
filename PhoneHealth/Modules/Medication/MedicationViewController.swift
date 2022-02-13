//
//  MedicationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import FSCalendar

class MedicationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var currentDate: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    let dateFormatter = DateFormatter()
    
    var viewModel: MedicationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationItem.title = "Medications"
        setupCells()
        dateFormatter.dateFormat = "EEE dd MMM"
        setup()
        setupViews()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupViews() {
        addBtn.rounded()
        addBtn.setTitle("", for: .normal)
    }
    
    func setupCells() {
        tableView.register(UINib.init(nibName: "MedicationListTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicationListTableViewCell")
    }
    
    @IBAction func addAction(_ sender: Any) {
        guard let nav = self.navigationController else {return}
        let coordinator = AddMedicationCoordinator.init(navigationController: nav)
        coordinator.start()
    }
    
    func setup() {
        rightBtn.setTitle("", for: .normal)
        leftBtn.setTitle("", for: .normal)
        
        calender.dataSource = self
        calender.delegate = self
        calender.scope = .week
        self.currentDate.text = dateFormatter.string(from: Date())
        rightBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        
    }
    
    @objc func nextAction() {
        calender.setCurrentPage(self.calender.currentPage.addingTimeInterval(604800), animated: true)
    }
    
    @objc func backAction() {
        calender.setCurrentPage(self.calender.currentPage.addingTimeInterval(-604800), animated: true)
    }

}

extension MedicationViewController:  FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.currentDate.text = dateFormatter.string(from: date)
    }
    
}

extension MedicationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationListTableViewCell") as! MedicationListTableViewCell
        cell.setupViews()
        return cell
    }
}
