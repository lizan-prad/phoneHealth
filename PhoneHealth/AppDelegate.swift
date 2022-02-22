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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: LoginCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: ColorConfig.baseColor]
        IQKeyboardManager.shared.enable = true
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UINavigationBar.appearance().tintColor = .darkGray
//        UINavigationBar.appearance().isTranslucent = false
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


}

