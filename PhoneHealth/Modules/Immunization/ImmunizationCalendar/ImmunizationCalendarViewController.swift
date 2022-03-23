//
//  ImmunizationCalendarViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 20/03/2022.
//

import UIKit
import FSCalendar

class ImmunizationCalendarViewController: UIViewController, Storyboarded {

    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var viewModel: ImmunizationCalendarViewModel!
    let dateFormatter = DateFormatter()
    
    var leftDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        leftDate = Date()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        
        dateFormatter.dateFormat = "MMMM yyyy"
        rightBtn.setTitle("", for: .normal)
        leftBtn.setTitle("", for: .normal)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.scope = .month
        self.monthLabel.text = dateFormatter.string(from: Date())
        rightBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
    }
    
    @objc func nextAction() {
        calendarView.setCurrentPage(leftDate?.addingTimeInterval(2419200) ?? Date(), animated: true)
        leftDate = leftDate?.addingTimeInterval(2419200) ?? Date()
        self.monthLabel.text = dateFormatter.string(from: leftDate ?? Date())
    }
     
    @objc func backAction() {
        calendarView.setCurrentPage(leftDate?.addingTimeInterval(-2419200) ?? Date(), animated: true)
        leftDate = leftDate?.addingTimeInterval(-2419200) ?? Date()
        self.monthLabel.text = dateFormatter.string(from: leftDate ?? Date())
    }

}

extension ImmunizationCalendarViewController:  FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let dateFormatter = DateFormatter()
//
//        self.currentDate.text = dateFormatter.string(from: date)
//        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
//        self.selectedDate = format.string(from: date).components(separatedBy: "T").first
//        format.dateFormat = "yyyy-MM-dd"
//        self.reminderDate = format.string(from: date)
    }
    
}
