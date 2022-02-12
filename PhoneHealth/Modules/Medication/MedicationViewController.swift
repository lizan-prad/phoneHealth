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
    
    let dateFormatter = DateFormatter()
    
    var viewModel: MedicationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "EEE dd MMM"
        self.setup()
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
