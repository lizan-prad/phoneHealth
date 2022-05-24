//
//  MedicationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import FSCalendar

class MedicationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var medicationHistoryBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var currentDate: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    let dateFormatter = DateFormatter()
    
    var selectedDate: Date? {
        didSet {
            let alarmFormat = DateFormatter()
            alarmFormat.dateFormat = "yyyy-MM-dd"
           
            medicationList = original?.filter({ model in
                let f = alarmFormat.date(from: model.firstIntake ?? "") ?? Date()
                let e = alarmFormat.date(from: model.expiryDate ?? "") ?? Date()
                return (f...e).contains(selectedDate ?? Date())
            })
        }
    }
    
    var viewModel: MedicationViewModel!
    var original: [MedicationDataModel]?  {
        didSet {
            let expired = medicationList?.filter({ model in
                let formatter = DateFormatter.init()
                formatter.dateFormat = "yyyy-MM-dd"
                let current = formatter.string(from: Date())
                return current == model.expiryDate
            })
            expired?.forEach({ model in
                model.time?.forEach({ time in
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(model.medicationId ?? 0)-\(time.id ?? 0)"])
                    print("notif removed")
                })
                
            })
            self.selectedDate = Date()
//            medicationList = original?.filter({ model in
//                let formatter = DateFormatter.init()
//                formatter.dateFormat = "yyyy-MM-dd"
//                let current = formatter.string(from: Date())
//                return current != model.expiryDate
//            })
        }
    }
    var medicationList: [MedicationDataModel]? {
        didSet {
            
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        medicationHistoryBtn.rounded()
        
        self.hideTabbar()
       
        setupCells()
        dateFormatter.dateFormat = "EEE dd MMM"
        setup()
        self.navigationController?.navigationBar.barTintColor = .white
        setupViews()
        if viewModel.isFromNotif {
            //            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Dashboard", style: .plain, target: self, action: #selector(goToHome))
            guard let nav = self.navigationController, let model = self.viewModel.model else {return}
            let coordinator = MedicationDetailCoordinator.init(navigationController: nav, model: model, isFromNotif: true)
            coordinator.start()
        }
    }
    
    @IBAction func historyAction(_ sender: Any) {
        guard let nav = self.navigationController else {return}
        let coordinator = MedicationHistoryCoordinator.init(navigationController: nav)
        coordinator.start()
    }
    
    
    @objc func goToHome() {
        let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
        appdelegate.window?.rootViewController = vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Medications"
        self.viewModel.fetchMedication()
        self.calender.select(Date())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    func bindViewModel() {
        self.viewModel.medications.bind { models in
            self.original = models
//            self.selectedDate = Date()
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
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
        self.selectedDate = date
        self.currentDate.text = dateFormatter.string(from: date)
    }
    
}

extension MedicationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationListTableViewCell") as! MedicationListTableViewCell
        cell.setupViews()
        cell.index = indexPath.row
        cell.model = self.medicationList?[indexPath.row]
        cell.didTurnOff = { index in
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: self.medicationList?[index].time?.compactMap({"\(self.self.medicationList?[index].medicationId ?? 0)-\($0.id ?? 0)"}) ?? [])
        }
        return cell
    }
}
