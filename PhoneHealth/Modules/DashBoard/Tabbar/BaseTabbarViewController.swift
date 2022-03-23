//
//  BaseTabbarViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 18/02/2022.
//

import UIKit

class BaseTabbarViewController: UITabBarController {

    let coustmeTabBarView:UIView = {
        
        //  daclare coustmeTabBarView as view
        let view = UIView(frame: .zero)
        
        // to make the cornerRadius of coustmeTabBarView
        view.backgroundColor = ColorConfig.baseColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        // to make the shadow of coustmeTabBarView
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(openHospitalTab), name: Notification.Name.init(rawValue: "TAB2"), object: nil)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        tabBar.layer.shadowOpacity = 0.4
        addcoustmeTabBarView()
//        hideTabBarBorder()

        NotificationCenter.default.addObserver(self, selector: #selector(hideAction), name: Notification.Name.init(rawValue: "HT"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAction), name: Notification.Name.init(rawValue: "ST"), object: nil)

    }
    
    @objc func openHospitalTab() {
        self.selectedIndex = 1
    }
  
    @objc func hideAction() {
        coustmeTabBarView.isHidden = true
    }
    
    @objc func showAction() {
        coustmeTabBarView.isHidden = false
    }
    


//    override func viewDidLayoutSubviews() {
//          super.viewDidLayoutSubviews()
//         coustmeTabBarView.frame = tabBar.frame
//      }
    
    override func viewDidAppear(_ animated: Bool) {
//        var newSafeArea = UIEdgeInsets()
//
//        // Adjust the safe area to the height of the bottom views.
//        newSafeArea.bottom += coustmeTabBarView.bounds.size.height
//
//        // Adjust the safe area insets of the
//        //  embedded child view controller.
//        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }

    private func addcoustmeTabBarView() {
        //
       coustmeTabBarView.frame = tabBar.frame
        
//        view.addSubview(coustmeTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .white)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true

    }
    

}






extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
