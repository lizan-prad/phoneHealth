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
        UITabBar.appearance().unselectedItemTintColor = .white
//        UITabBarItem.appearance().imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0)
        let navController = UINavigationController()
        coordinator = LoginCoordinator(navigationController: navController)

//        coordinator?.start()
        let vc = UIStoryboard.init(name: "BaseTabbar", bundle: nil).instantiateViewController(withIdentifier: "BaseTabbarViewController") as! BaseTabbarViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        
        // Override point for customization after application launch.
        return true
    }


}

