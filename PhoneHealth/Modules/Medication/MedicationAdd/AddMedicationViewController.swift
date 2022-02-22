//
//  AddMedicationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import FSCalendar
import EventKit

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
    
    let frequencyPicker = UIPickerView()
    let quantityPicker = UIPickerView()
    let medicationPicker = UIPickerView()
    let firstIntakePicker = UIDatePicker()
    
    var selectedTime: String?
    var selectedDate: String?
    var eventStore = EKEventStore.init()
    let frequencies = [1, 2, 3, 4]
    let quantities = [1, 2, 3, 4]
    let medications = ["Paracitamol 500mg", "Asprine", "Icon 100mg", "Niko 500mg", "Buscopan", "Flexon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "EEE dd MMM"
        setup()
        bindViewModel()
        
        firstIntakePicker.preferredDatePickerStyle = .wheels
        firstIntake.inputView = firstIntakePicker
        frequency.inputView = frequencyPicker
        medicineName.inputView = medicationPicker
        quantity.inputView = quantityPicker
        
        firstIntakePicker.datePickerMode = .time
        firstIntakePicker.addTarget(self, action: #selector(selectedTime(_:)), for: .valueChanged)
        numberOfDays.keyboardType = .numberPad
        
        frequencyPicker.dataSource = self
        frequencyPicker.delegate = self
        quantityPicker.dataSource = self
        quantityPicker.delegate = self
        medicationPicker.dataSource = self
        medicationPicker.delegate = self
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }
    
    func bindViewModel() {
        self.viewModel.success.bind { _ in
           
                self.AddReminder(title: self.medicineName.text ?? "", priority: 1, note: "Take your meds", alarmTIme: "\(self.selectedDate ?? "")T\(self.selectedTime ?? "")")
            
            
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    @objc func saveAction() {
        self.viewModel.addMedicaiton(model: MedicaitonModel.init(firstIntake: "\(self.selectedDate ?? "")T\(self.selectedTime ?? "")", frequency: Int(self.frequency.text ?? ""), medicineName: self.medicineName.text, numberOfDays: Int(self.numberOfDays.text ?? ""), quantity: self.quantity.text))
    }
    
    @objc func selectedTime(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm a"
        self.firstIntake.text = format.string(from: sender.date)
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        self.selectedTime = format.string(from: sender.date).components(separatedBy: "T").last
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
    
    func AddReminder(title: String, priority: Int, note: String, alarmTIme: String) {
        let format = DateFormatter()
        format.dateFormat = "yyyy-mm-dd'T'hh:mm:ss.sss'Z'"
        let date = format.date(from: alarmTIme)
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            granted, error in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                
                
                let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
                reminder.title = title
                reminder.priority = 1
                
                //  How to show completed
                //reminder.completionDate = Date()
                
                reminder.notes = note
                
                
                let alarmTime = date ?? Date()
                let alarm = EKAlarm(absoluteDate: alarmTime)
                reminder.addAlarm(alarm)
                
                reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                
                
                do {
                    try self.eventStore.save(reminder, commit: true)
                } catch {
                    self.showAlert(title: nil, message: error.localizedDescription) { _ in
                        
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.showAlert(title: nil, message: "Medication reminder set") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        })
        
    }


}

extension AddMedicationViewController:  FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        self.currentDate.text = dateFormatter.string(from: date)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        self.selectedDate = format.string(from: date).components(separatedBy: "T").first
        
    }
    
}

extension AddMedicationViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case frequencyPicker:
            return frequencies.count
        case quantityPicker:
            return quantities.count
        case medicationPicker:
            return medications.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case frequencyPicker:
            return "\(frequencies[row])"
        case quantityPicker:
            return "\(quantities[row])"
        case medicationPicker:
            return medications[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case frequencyPicker:
            self.frequency.text = "\(frequencies[row])"
        case quantityPicker:
            self.quantity.text = "\(quantities[row])"
        case medicationPicker:
            self.medicineName.text = medications[row]
        default:
            break
        }
    }
}

