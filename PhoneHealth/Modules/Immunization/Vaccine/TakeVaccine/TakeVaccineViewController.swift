//
//  TakeVaccineViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 15/04/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

struct ImmunizationTakeModel {
    var date: Date?
    var location: String?
    var remarks: String?
}

class TakeVaccineViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var remarks: MDCOutlinedTextField!
    @IBOutlet weak var location: MDCOutlinedTextField!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var vaccinationName: UILabel!
    @IBOutlet weak var selectDate: UIButton!
    @IBOutlet weak var container: UIView!
    
    var model: AvailableVaccinesList?
    
    let formatter = DateFormatter()
    
    let datePicker = UIDatePicker()
    var selectedDate: Date?
    
    var didFinishedTaking: ((ImmunizationTakeModel, AvailableVaccinesList?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDate()
        self.vaccinationName.text = model?.vaccinationName
    }
    
    func setupDate() {
        formatter.dateFormat = "dd MMM yyyy"
        selectDate.setTitle(formatter.string(from: Date()), for: .normal)
    }
    
    func setup() {
        
        container.addCornerRadius(12)
        selectDate.rounded()
        location.setup("Location")
        remarks.setup("Remarks")
        saveBtn.rounded()
        cancelBtn.rounded()
        cancelBtn.addBorder(.darkGray)
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
        let pickerSize : CGSize = datePicker.sizeThatFits(CGSize.zero)
        datePicker.frame = CGRect(x:0.0, y:view.frame.height - 400, width:view.frame.width, height:400)
        
    }
    
    @objc func didSelectDate(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
        self.selectDate.setTitle(formatter.string(from: sender.date), for: .normal)
        sender.removeFromSuperview()
    }
    
    @IBAction func selectDateAction(_ sender: Any) {
        self.view.addSubview(datePicker)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.didFinishedTaking?(ImmunizationTakeModel.init(date: self.selectedDate, location: self.location.text ?? "", remarks: self.remarks.text ?? ""), self.model)
        }
        
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
