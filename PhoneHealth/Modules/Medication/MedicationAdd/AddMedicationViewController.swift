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

    @IBOutlet weak var medicationbtn: UIButton!
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
    var reminderDate: String?
    var reminderTime: String?
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
        self.navigationItem.title = "Add Medication"
        self.navigationController?.navigationBar.barTintColor = .white
        dateFormatter.dateFormat = "EEE dd MMM"
        setup()
        bindViewModel()
        self.calender.select(Date())
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        self.selectedDate = format.string(from: Date()).components(separatedBy: "T").first
        format.dateFormat = "yyyy-MM-dd"
        self.reminderDate = format.string(from: Date())
        
        firstIntakePicker.preferredDatePickerStyle = .wheels
        firstIntake.inputView = firstIntakePicker
        frequency.inputView = frequencyPicker
        medicineName.inputView = medicationPicker
        quantity.inputView = quantityPicker
        medicationbtn.setTitle("", for: .normal)
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
        
        medicationbtn.addTarget(self, action: #selector(openMedicationSearch), for: .touchUpInside)
    }
    
    @objc func openMedicationSearch() {
        let vc = UIStoryboard.init(name: "SearchMedication", bundle: nil).instantiateViewController(withIdentifier: "SearchMedicationViewController") as! SearchMedicationViewController
        vc.didTapAdd = { medName in
            self.medicineName.text = medName
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func bindViewModel() {
        self.viewModel.success.bind { model in
            let format = DateFormatter()
            format.locale = .current
            format.dateFormat = "yyyy-MM-dd hh:mm a"
            let date = format.date(from: "\(self.reminderDate ?? "") \(self.reminderTime ?? "")")
            self.showAlert(title: nil, message: "Medication reminder set") { _ in
                self.navigationController?.popViewController(animated: true)
            }
//            self.setNotification(date: date ?? Date(), title: self.medicineName.text ?? "", body: "Take your meds", id: "Medication-\(model?.medicationId ?? 0)")
//                self.AddReminder(title: self.medicineName.text ?? "", priority: 1, note: "Take your meds", alarmTIme: "\(self.selectedDate ?? "")T\(self.selectedTime ?? "")")
            
            
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
        
        format.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.sss'Z'"
        format.timeZone = TimeZone(abbreviation: "GMT")
        self.selectedTime = format.string(from: sender.date).components(separatedBy: "T").last
        format.timeZone = TimeZone.current
        format.dateFormat = "hh:mm"
        self.reminderTime = format.string(from: sender.date)
        format.dateFormat = "HH:mm a"
        self.firstIntake.text = format.string(from: sender.date)
        
        
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
        format.locale = .current
//        format.timeZone = TimeZone(abbreviation: "GMT")
        format.dateFormat = "yyyy-MM-dd HH:mm a"
        let date = format.date(from: "\(self.reminderDate ?? "") \(self.reminderTime ?? "")")
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
            granted, error in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                
                
                let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
                reminder.title = title
                reminder.priority = 3
                
                //  How to show completed
                //reminder.completionDate = Date()
                
                reminder.notes = note
                
                
                let alarmTime = date ?? Date()
                let alarm = EKAlarm(absoluteDate: alarmTime)
                reminder.addAlarm(alarm)
                
                reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                reminder.timeZone = TimeZone(abbreviation: "GMT")
                
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

    func setNotification(date: Date, title: String, body: String, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .critical
        } else {
            // Fallback on earlier versions
        }
        content.userInfo = ["pills_no": self.quantity.text ?? "", "time": self.firstIntake.text ?? "", "id": id]
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName.init(rawValue: "alert.mp3"))
        let dateComponents = Calendar.current.dateComponents([.year, .day, .month,.hour, .minute], from: date)
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        let uuidString = id
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
               self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                   
               }
               } else {
                   DispatchQueue.main.async {
                       self.showAlert(title: nil, message: "Medication reminder set") { _ in
                           self.navigationController?.popViewController(animated: true)
                       }
                   }
           }
        }
    }

}

extension AddMedicationViewController:  FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        self.currentDate.text = dateFormatter.string(from: date)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        self.selectedDate = format.string(from: date).components(separatedBy: "T").first
        format.dateFormat = "yyyy-MM-dd"
        self.reminderDate = format.string(from: date)
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

