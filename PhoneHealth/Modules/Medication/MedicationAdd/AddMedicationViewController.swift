//
//  AddMedicationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import FSCalendar

class AddMedicationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var numberOfDays: MDCOutlinedTextField!
    @IBOutlet weak var firstIntake: MDCOutlinedTextField!
    @IBOutlet weak var frequency: MDCOutlinedTextField!
    @IBOutlet weak var quantity: MDCOutlinedTextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var medicineName: MDCOutlinedTextField!
    
    let dateFormatter = DateFormatter()
    var viewModel: AddMedicationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "EEE dd MMM"
        setup()
    }
    
    func setup() {
        numberOfDays.setup("Number of Days")
        firstIntake.setup("First Intake")
        frequency.setup("Frequency")
        quantity.setup("Quantity")
        medicineName.setup("Medicine Name")
        saveBtn.addCornerRadius(12)
        
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

extension AddMedicationViewController:  FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        self.currentDate.text = dateFormatter.string(from: date)
    }
    
}
