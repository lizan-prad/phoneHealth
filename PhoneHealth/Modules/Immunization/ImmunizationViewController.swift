//
//  ImmunizationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 20/03/2022.
//

import UIKit

class ImmunizationViewController: UIViewController {

    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var backgroundsView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var vaccineLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var currentImmuContainer: UIView!
    @IBOutlet weak var profileCardView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationItem.title = "Immunization"
    }

    func setup() {
        self.backImage.addCornerRadius(12)
        self.gradientView.addCornerRadius(12)
        self.backgroundsView.addCornerRadius(12)
        self.gradientView.setGradientLeftRightNoExtra(UIColor.black, endColor: UIColor.init(hex: "22D7F2"))
        self.backgroundsView.addBorder(UIColor.lightGray.withAlphaComponent(0.2))
        
        profileImageLabel.addCornerRadius(35)
        
        profileImageLabel.addBorderwith(.white, width: 3)
        self.profileCardView.setStandardShadow()
        self.profileCardView.addCornerRadius(12)
        self.menuContainer.setStandardShadow()
        self.menuContainer.rounded()
        self.selectedView.rounded()
        
        
        vaccineLabel.isUserInteractionEnabled = true
        historyLabel.isUserInteractionEnabled = true
        calendarLabel.isUserInteractionEnabled = true
        
        vaccineLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapVaccine)))
        historyLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapHistory)))
        calendarLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapCalendar)))
    }
    
    @objc func didTapVaccine() {
        
        UIView.animate(withDuration: 0.3) {
            //Change position of your UnderlineBar
            self.historyLabel.textColor = .black.withAlphaComponent(0.6)
            self.calendarLabel.textColor = .black.withAlphaComponent(0.6)
            self.vaccineLabel.textColor = .white
            self.selectedView.frame = self.vaccineLabel.frame
            self.view.layoutIfNeeded()
        }
//        self.currentHealthSection = .details
    }
    
    
    @objc func didTapHistory() {
        
        UIView.animate(withDuration: 0.3) {
            //Change position of your UnderlineBar
            self.calendarLabel.textColor = .black.withAlphaComponent(0.6)
            self.vaccineLabel.textColor = .black.withAlphaComponent(0.6)
            self.historyLabel.textColor = .white
            self.selectedView.frame = self.historyLabel.frame
            self.view.layoutIfNeeded()
        }
//        self.currentHealthSection = .allergies
    }
    
    @objc func didTapCalendar() {
        UIView.animate(withDuration: 0.3) {
            //Change position of your UnderlineBar
            self.historyLabel.textColor = .black.withAlphaComponent(0.6)
            self.vaccineLabel.textColor = .black.withAlphaComponent(0.6)
            self.calendarLabel.textColor = .white
            self.selectedView.frame = self.calendarLabel.frame
            self.view.layoutIfNeeded()
        }
//        self.currentHealthSection = .diseases
    }
}
