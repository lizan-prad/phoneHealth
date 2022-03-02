//
//  AppDelegate.swift
//  PhoneHealth
//
//  Created by Lizan on 06/01/2022.
//

import UIKit
import IQKeyboardManagerSwift

let appdelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var coordinator: LoginCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: ColorConfig.baseColor]
        IQKeyboardManager.shared.enable = true
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UINavigationBar.appearance().tintColor = .darkGray
        
//        UINavigationBar.appearance().isTranslucent = false
        if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (status, error) in
                if status {
                        print("Permission granted. Scheduling notification")
                    }
            }
        }
        UINavigationBar.appearance().barTintColor = UIColor.init(hex: "F5FAFA")
//        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "custom-back")
//        UITabBarItem.appearance().imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0)
        if let _ = UserDefaults.standard.value(forKey: "AT") as? String {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
            self.window?.rootViewController = vc
            window?.makeKeyAndVisible()
            window?.overrideUserInterfaceStyle = .light
            return true
        }
        
            
        let navController = UINavigationController()
        coordinator = LoginCoordinator(navigationController: navController)

        coordinator?.start()
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        
        // Override point for customization after application launch.
        return true
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        switch UIApplication.shared.applicationState {
        case .active:
            //            print("active")
            
            completionHandler([.sound])
            
        default:
            completionHandler([.alert, .sound, .badge])
            
        }
        
        
        
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter,
                didReceive response: UNNotificationResponse,
                withCompletionHandler completionHandler:
                   @escaping () -> Void) {
       // Get the meeting ID from the original notification.
       let userInfo = response.notification.request.content.userInfo
            let time = userInfo["time"] as? String
        let pills = userInfo["pills_no"] as? String
        let model = MedicationAlertModel.init(time: time, numberOfPill: pills, id: response.notification.request.content.categoryIdentifier, title: response.notification.request.content.title)
        let navController = UINavigationController()
        let coordinator = MedicationCoordinator(navigationController: navController)
        coordinator.isfromNotif = true
        coordinator.model = model
        coordinator.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
//       if response.notification.request.content.categoryIdentifier ==
//                  "MEETING_INVITATION" {
          // Retrieve the meeting details.
//          let meetingID = userInfo["MEETING_ID"] as! String
//          let userID = userInfo["USER_ID"] as! String
//
//          switch response.actionIdentifier {
//          case "ACCEPT_ACTION":
////             sharedMeetingManager.acceptMeeting(user: userID,
////                   meetingID: meetingID)
//             break
//
//          case "DECLINE_ACTION":
////             sharedMeetingManager.declineMeeting(user: userID,
////                   meetingID: meetingID)
//             break
//
//          case UNNotificationDefaultActionIdentifier,
//               UNNotificationDismissActionIdentifier:
//             // Queue meeting-related notifications for later
//             //  if the user does not act.
////             sharedMeetingManager.queueMeetingForDelivery(user: userID,
////                   meetingID: meetingID)
//             break
//
//          default:
//             break
//          }
//       }
//       else {
//          // Handle other notification types...
//       }
//       }
       // Always call the completion handler when done.
       completionHandler()
    }
}

