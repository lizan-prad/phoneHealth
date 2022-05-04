//
//  MedicationListTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 13/02/2022.
//

import UIKit
import PDFKit

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1 // <1>
    }
}

class MedicationListTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var medDate: UILabel!
    @IBOutlet weak var medQuantity: UILabel!
    @IBOutlet weak var medName: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var time = [Date]()
    var index: Int?
    var didTurnOff: ((Int) -> ())?
    var expoiry: String?
    
    func get24Hrs(str: String) -> String {
        let val = str.components(separatedBy: ":").first ?? ""
        let last = str.components(separatedBy: ":").last ?? ""
        
        return (Int(val) ?? 0) < 12 ? (str + " am") : "\(((Int(val) ?? 0) + 12) - 24):\(last) pm".replacingOccurrences(of: "-", with: "")
    }
    
    var model: MedicationDataModel? {
        didSet {
            
            let alarmFormat = DateFormatter()
            alarmFormat.dateFormat = "yyyy-MM-dd"
            self.expoiry = model?.expiryDate
            
            
            let d = alarmFormat.string(from: Date())
            if d == model?.firstIntake {
                alarmFormat.dateFormat = "yyyy-MM-dd HH:mm"
    //            alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT")
                let times = model?.time?.compactMap({"\(d) \(self.get24Hrs(str: $0.time ?? ""))"})
                alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT")
                self.time = times?.compactMap({alarmFormat.date(from: $0)}) ?? []
                medName.text = model?.medicineName
                doseLabel.text = (model?.dose?.replacingOccurrences(of: "mg", with: "") ?? "") + "mg"
                alarmFormat.timeZone = TimeZone.current
                let formatter = DateFormatter()
                let date = formatter.date(from: model?.firstIntake ?? "") ?? Date()
                formatter.dateFormat = "dd MMM"
                medDate.text = "\(formatter.string(from: date)) - \(formatter.string(from: date.addingTimeInterval(TimeInterval(86400*(model?.numberOfDays ?? 0)))))"
                medQuantity.text = "Quantity - \(model?.quantity ?? "0") Pills"
                collectionView.reloadData()
                collectionView.register(UINib.init(nibName: "TimeAlertCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeAlertCollectionViewCell")
                //            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                self.container.alpha = 1
                self.alertSwitch.isOn = true
                
                if !UserDefaults.standard.bool(forKey: "Medication-\(self.model?.medicationId ?? 0)") {
                    self.container.alpha = 1
                    self.alertSwitch.isOn = true
                    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                        self.model?.time?.enumerated().forEach { (index, date) in
                            print(self.model?.medicationId ?? 0, self.model?.time?[index].id ?? 0)
                            if requests.compactMap({($0.content.userInfo["id"] as? String)}).filter({$0 == "\(self.model?.medicationId ?? 0)-\(date.id ?? 0)"}).count == 0 {
                                
                                self.setNotification(takeTime: date.time ?? "", date: self.time[index], title: self.model?.medicineName ?? "", body: "Take your meds", id: "\(self.model?.medicationId ?? 0)-\(date.id ?? 0)", repeats: true)
                            }
                        }
                    }
                } else {
                    self.container.alpha = 0.5
                    self.alertSwitch.isOn = false
                }
                alertSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
            } else {
                alarmFormat.dateFormat = "yyyy-MM-dd HH:mm"
    //            alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT")
                let times = model?.time?.compactMap({"\(self.model?.firstIntake ?? "") \(self.get24Hrs(str: $0.time ?? ""))"})
                alarmFormat.timeZone = TimeZone.init(abbreviation: "GMT")
                self.time = times?.compactMap({alarmFormat.date(from: $0)}) ?? []
                medName.text = model?.medicineName
                doseLabel.text = (model?.dose?.replacingOccurrences(of: "mg", with: "") ?? "") + "mg"
                alarmFormat.timeZone = TimeZone.current
                let formatter = DateFormatter()
                let date = formatter.date(from: model?.firstIntake ?? "") ?? Date()
                formatter.dateFormat = "dd MMM"
                medDate.text = "\(formatter.string(from: date)) - \(formatter.string(from: date.addingTimeInterval(TimeInterval(86400*(model?.numberOfDays ?? 0)))))"
                medQuantity.text = "Quantity - \(model?.quantity ?? "0") Pills"
                collectionView.reloadData()
                collectionView.register(UINib.init(nibName: "TimeAlertCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeAlertCollectionViewCell")
                //            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                self.container.alpha = 1
                self.alertSwitch.isOn = true
                
                if !UserDefaults.standard.bool(forKey: "Medication-\(self.model?.medicationId ?? 0)") {
                    self.container.alpha = 1
                    self.alertSwitch.isOn = true
                    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                        self.model?.time?.enumerated().forEach { (index, date) in
                            print(self.model?.medicationId ?? 0, self.model?.time?[index].id ?? 0)
                            if requests.compactMap({($0.content.userInfo["id"] as? String)}).filter({$0 == "\(self.model?.medicationId ?? 0)-\(date.id ?? 0)"}).count == 0 {
                                
                                self.setNotification(takeTime: date.time ?? "", date: self.time[index], title: self.model?.medicineName ?? "", body: "Take your meds", id: "\(self.model?.medicationId ?? 0)-\(date.id ?? 0)", repeats: true)
                            }
                        }
                    }
                } else {
                    self.container.alpha = 0.5
                    self.alertSwitch.isOn = false
                }
                alertSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
            }
            
        }
    }
    
    @objc func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(false, forKey: "Medication-\(self.model?.medicationId ?? 0)")
            self.container.alpha = 1
            self.model?.time?.enumerated().forEach({ index,model in
                self.setNotification(takeTime: model.time ?? "" ,date: self.time[index], title: self.model?.medicineName ?? "", body: "Take your meds", id: "\(self.model?.medicationId ?? 0)-\(model.id ?? 0)")
            })
        } else {
            UserDefaults.standard.set(true, forKey: "Medication-\(self.model?.medicationId ?? 0)")
            self.container.alpha = 0.5
            self.didTurnOff?(index ?? 0)
        }
    }
    
    func setNotification(takeTime: String, date: Date, title: String, body: String, id: String, repeats: Bool? = false) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .critical
        } else {
            // Fallback on earlier versions
        }
        content.userInfo = ["timeAlert": takeTime, "pills_no": self.model?.quantity ?? "", "time": self.model?.firstIntake ?? "", "id" : id]
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName.init(rawValue: "alert.mp3"))
    
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date.addingTimeInterval(-20700))
//        dateComponents.timeZone = TimeZone.current
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        
        let uuidString = id
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              
               } else {
                   DispatchQueue.main.async {
                      print("set reminders")
                   }
           }
        }
    }
    
    
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        container.addCornerRadius(12)
        moreBtn.setTitle("", for: .normal)
        
        container.addBorder(.lightGray.withAlphaComponent(0.2))
        
        alertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        doseLabel.addBorder(ColorConfig.baseColor)
        doseLabel.textColor = ColorConfig.baseColor
        doseLabel.addCornerRadius(2)
    }
}

extension MedicationListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.time.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeAlertCollectionViewCell", for: indexPath) as! TimeAlertCollectionViewCell
        let format = DateFormatter()
        format.timeZone = TimeZone.init(abbreviation: "GMT")
        format.dateFormat = "h:mm a"
        cell.timeLabel.text = format.string(from: self.time[indexPath.row])
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 90, height: 30)
    }
}
