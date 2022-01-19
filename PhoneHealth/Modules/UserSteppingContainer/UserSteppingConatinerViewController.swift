//
//  UserSteppingConatinerViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 09/01/2022.
//

import UIKit

class UserSteppingConatinerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var s5lbl: UILabel!
    @IBOutlet weak var s4lbl: UILabel!
    @IBOutlet weak var s3lbl: UILabel!
    @IBOutlet weak var s2lbl: UILabel!
    @IBOutlet weak var s1Lbl: UILabel!
    @IBOutlet weak var step5: UIView!
    @IBOutlet weak var step4: UIView!
    @IBOutlet weak var step3: UIView!
    @IBOutlet weak var step2: UIView!
    @IBOutlet weak var step1: UIView!
    @IBOutlet weak var container: UIView!
    
    var viewModel: UserSteppingViewModel!
    
    enum UserBasicSteps: Int {
        case basic = 1
        case allergy
        case cronic
        case habits
        case food
    }
    
    var basicViewController: UserBasicViewController {
        guard let nav = self.navigationController else {return UserBasicViewController()}
        let coordinator = UserBasicCoordinator.init(navigationController: nav)
        let vc = coordinator.getMainView()
        vc.didTapNext = { index in
            self.step1.addBorder(.clear)
            self.step1.backgroundColor = ColorConfig.baseColor
            self.s1Lbl.textColor = .white
            self.step2.addBorder(ColorConfig.baseColor)
            self.step2.backgroundColor = .white
            self.s2lbl.textColor = ColorConfig.baseColor
            self.basicViewController.removeFromParent()
            self.container.addChildViewController(self.allergyViewController, parentViewController: self)
        }
        vc.didTapBack = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        return vc
    }
    
    var allergyViewController: UserAlleryViewController {
        guard let nav = self.navigationController else {return UserAlleryViewController()}
        let coordinator = UserAllergyCoordinator.init(navigationController: nav)
        let vc = coordinator.getMainView()
        
        
        vc.didTapBack = { _ in
            self.s1Lbl.textColor = ColorConfig.baseColor
            self.s2lbl.textColor = .white
            self.step1.addBorder(ColorConfig.baseColor)
            self.step1.backgroundColor = .white
            self.step2.addBorder(.clear)
            self.step2.backgroundColor = ColorConfig.baseColor
            self.allergyViewController.removeFromParent()
            self.container.addChildViewController(self.basicViewController, parentViewController: self)
        }
        
        vc.didTapNext = { _ in
            self.step2.addBorder(.clear)
            self.step2.backgroundColor = ColorConfig.baseColor
            self.s2lbl.textColor = .white
            self.step3.addBorder(ColorConfig.baseColor)
            self.step3.backgroundColor = .white
            self.s3lbl.textColor = ColorConfig.baseColor
            self.allergyViewController.removeFromParent()
            self.container.addChildViewController(self.cronicViewController, parentViewController: self)
        }
        
        return vc
    }
    
    var cronicViewController: UserCronicViewController {
        guard let nav = self.navigationController else {return UserCronicViewController()}
        let coordinator = UserCronicCoordinator.init(navigationController: nav)
        let vc = coordinator.getMainView()
        
        
        vc.didTapBack = { _ in
            self.s3lbl.textColor = .white
            self.s2lbl.textColor = ColorConfig.baseColor
            self.step2.addBorder(ColorConfig.baseColor)
            self.step2.backgroundColor = .white
            self.step3.addBorder(.clear)
            self.step3.backgroundColor = ColorConfig.baseColor
            self.cronicViewController.removeFromParent()
            self.container.addChildViewController(self.allergyViewController, parentViewController: self)
        }
        
        vc.didTapNext = { _ in
            self.step3.addBorder(.clear)
            self.step3.backgroundColor = ColorConfig.baseColor
            self.s3lbl.textColor = .white
            self.step4.addBorder(ColorConfig.baseColor)
            self.step4.backgroundColor = .white
            self.s4lbl.textColor = ColorConfig.baseColor
            self.cronicViewController.removeFromParent()
            self.container.addChildViewController(self.habitsViewController, parentViewController: self)
        }
        
        return vc
    }
    
    var habitsViewController: HabitsViewController {
        guard let nav = self.navigationController else {return HabitsViewController()}
        let coordinator = HabitsCoordinator.init(navigationController: nav)
        let vc = coordinator.getMainView()
        
        
        vc.didTapBack = { _ in
            self.s4lbl.textColor = .white
            self.s3lbl.textColor = ColorConfig.baseColor
            self.step3.addBorder(ColorConfig.baseColor)
            self.step3.backgroundColor = .white
            self.step4.addBorder(.clear)
            self.step4.backgroundColor = ColorConfig.baseColor
            self.habitsViewController.removeFromParent()
            self.container.addChildViewController(self.cronicViewController, parentViewController: self)
        }
        
        vc.didTapNext = { _ in
            
        }
        
        return vc
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        step1.rounded()
        step2.rounded()
        step3.rounded()
        step4.rounded()
        step5.rounded()
        step1.addBorder(UIColor.init(hex: "46C9BD"))
        container.addCornerRadius(36)
        self.container.addChildViewController(basicViewController, parentViewController: self)
    }
    
    func getViewController(_ withTag: Int) {
        
    }
}
