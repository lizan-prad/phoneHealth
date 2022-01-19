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
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        IQKeyboardManager.shared.enable = true
        
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

