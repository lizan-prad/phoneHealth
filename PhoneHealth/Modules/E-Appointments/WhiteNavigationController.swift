//
//  WhiteNavigationController.swift
//  CogentIOS
//
//  Created by Aashish Karn on 26/01/2022.
//

import Foundation
import UI
import UIKit

class WhiteNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = .white
        let image = UIImage().imageWithColor(color: ThemeManager.Color.esewaMainColor)
        self.navigationBar.shadowImage = image
        self.navigationBar.setBackgroundImage(image, for: .default)
        // Navigation Bar Color
        //self.navigationBar.tintColor = Theme.Color.primaryText
        self.navigationBar.barTintColor = .white
            //ThemeManager.Color.esewaMainColor
        self.navigationBar.isOpaque = true
        self.navigationBar.isTranslucent = false
        
        // Remove text in backbutton navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        self.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "ic_nav_back")
        //self.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_nav_back")
        self.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: ThemeManager.Font.medium16]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        if #available(iOS 13.0, *) {
            super.traitCollectionDidChange(previousTraitCollection)
            let image = UIImage().imageWithColor(color: ThemeManager.Color.esewaMainColor)
            
            self.navigationBar.shadowImage = image
            self.navigationBar.setBackgroundImage(image, for: .default)
        }
    }
}

