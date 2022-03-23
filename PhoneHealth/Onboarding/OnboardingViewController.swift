//
//  OnboardingViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 03/03/2022.
//

import UIKit
import OnboardKit

class OnboardingViewController: UIViewController, Storyboarded {

    
    var viewModel: OnboardingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let pages = (1 ... 4).map({OnboardPage.init(title: $0 == 1 ? "Welcome" : ($0 == 2 ? "Medication" : ($0 == 3 ? "Family Profile" : "Connect Hospital")), imageName: "onboarding\($0)", description: $0 == 1 ? "Your personal locker where you can keep medical reports by scanning physical reports." : ($0 == 2 ? "Track your medications, receives alerts to take your medicines." : ($0 == 3 ? "Store and track family medical information in one accessible and secure location. " : "Connect to your hospital account and import medical reports and doctor visits.")), advanceButtonTitle: $0 == 4 ? "Get Started" : "Next", actionButtonTitle: $0 == 4 ? "" : "") { _ in }})
       
        let vc = OnboardViewController.init(pageItems: pages, appearanceConfiguration: OnboardViewController.AppearanceConfiguration.init(tintColor: ColorConfig.baseColor, titleColor: ColorConfig.baseColor, textColor: ColorConfig.baseColor, backgroundColor: UIColor.init(hex: "F5FAFA"), imageContentMode: .scaleAspectFit, titleFont: UIFont.systemFont(ofSize: 24), textFont: UIFont.systemFont(ofSize: 16, weight: .medium), advanceButtonStyling: nil, actionButtonStyling: nil)) {
            guard let nav = self.navigationController else {return}
            let coordinator = LoginCoordinator.init(navigationController: nav)
            coordinator.start()
        }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension OnboardingViewController{
}
