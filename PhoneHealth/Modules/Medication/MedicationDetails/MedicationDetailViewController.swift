//
//  MedicationDetailViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import UIKit

struct MedicationAlertModel {
    var alertTime: String?
    var time: String?
    var numberOfPill: String?
    var id: String?
    var title: String?
}

class MedicationDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var snoozeBtn: UIButton!
    @IBOutlet weak var takeBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var alarmdetajls: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmDesc: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    var viewModel: MedicationDetailViewModel!
    var id: String?
    var isFromNotif: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipBtn.setTitle("", for: .normal)
        takeBtn.setTitle("", for: .normal)
        snoozeBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        container.addCornerRadius(12)
        
        if isFromNotif {
            self.alarmDesc.text = "Its time to take your \(viewModel.model.time ?? "") Med(s)."
            self.alarmTimeLabel.text = viewModel.model.alertTime
            self.alarmName.text = viewModel.model.title
            self.alarmdetajls.text = "\(self.viewModel.model.title?.components(separatedBy: " ").last ?? ""), Take \(self.viewModel.model.numberOfPill ?? "") Pill(s)"
        } else {
            self.alarmDesc.text = "Your next medication alert is at \(viewModel.model.time ?? "")"
            self.alarmTimeLabel.text = viewModel.model.alertTime
            self.alarmName.text = viewModel.model.title
            self.alarmdetajls.text = "\(self.viewModel.model.title?.components(separatedBy: " ").last ?? ""), Take \(self.viewModel.model.numberOfPill ?? "") Pill(s)"
            takeBtn.isEnabled = false
            skipBtn.isEnabled = false
            snoozeBtn.isEnabled = false
        }
        takeBtn.rounded()
        skipBtn.rounded()
        snoozeBtn.rounded()
        self.takeBtn.addTarget(self, action: #selector(takeAction), for:
                                    .touchUpInside)
        
        self.closeBtn.addTarget(self, action: #selector(closeAction), for:
                                    .touchUpInside)
        self.skipBtn.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        self.snoozeBtn.addTarget(self, action: #selector(snoozeAction), for: .touchUpInside)
        
        viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
        
        self.viewModel.success.bind { status in
            self.showAlert(title: nil, message: self.viewModel.getMsg(status: status ?? "")) { _ in
               
                switch status {
                case "S":
                    let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
                    appdelegate.window?.rootViewController = vc
                case "O":
                    self.setNotification(date: Date().addingTimeInterval(600), title: self.viewModel.model.title ?? "", body: "Take your meds", id: "snooze")
                case "T":
                    let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
                    appdelegate.window?.rootViewController = vc
                default: break
                }
            }
        }
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func snoozeAction() {
        self.showAlert(title: nil, message: "You have snoozed your alarm for 10mins") { _ in
            self.viewModel.medicationAction(status: "O", id: self.viewModel.model.id ?? "")
            
        }
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
        content.userInfo = ["pills_no": self.viewModel.model.numberOfPill ?? "", "time": self.viewModel.model.time ?? "", "id": id]
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName.init(rawValue: "alert.mp3"))
        let dateComponents = Calendar.current.dateComponents([.year, .day, .month,.hour, .minute], from: date)
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: false)
        
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
                           let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
                           appdelegate.window?.rootViewController = vc
                       }
                   }
           }
        }
    }
    
    @objc func skipAction() {
        let alert = UIAlertController.init(title: nil, message: "Are you sure you want to skip?", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .destructive) { _ in
            self.viewModel.medicationAction(status: "S", id: self.viewModel.model.id ?? "")
        }
        let cancel = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func takeAction() {
        self.showAlert(title: "Great Job!", message: "Thank you for taking your meds in time.") { _ in
            self.viewModel.medicationAction(status: "T", id: self.viewModel.model.id ?? "")
            
        }
    }
    


}
