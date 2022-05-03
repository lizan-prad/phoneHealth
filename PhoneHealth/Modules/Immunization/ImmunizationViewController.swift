//
//  ImmunizationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 20/03/2022.
//

import UIKit

class ImmunizationViewController: UIViewController, Storyboarded {

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
    
    @IBOutlet weak var childAge: UILabel!
    @IBOutlet weak var childName: UILabel!
    @IBOutlet weak var upcommingVaccinationName: UILabel!
    @IBOutlet weak var vaccinationDaysLeft: UILabel!
    @IBOutlet weak var vaccinationFor: UILabel!
    
    var viewModel: ImmunizationViewModel!
    
    enum ImmunizationType {
        case vaccine
        case calendar
        case history
    }
    
    var currentImmunizationView: ImmunizationType? {
        didSet {
            self.containerView.addChildViewController(currentImmunizationView == .vaccine ? vaccinationVc : ( currentImmunizationView == .calendar ? calenderVc : historyVc), parentViewController: self)
        }
    }
    
    var vaccinationVc: VaccineViewController {
        guard let nav = self.navigationController else {return VaccineViewController()}
        let coordinator = VaccineCoordinator.init(navigationController: nav)
        coordinator.vaccineType = .present
        coordinator.model = self.model?.availableVaccineList
        coordinator.id = self.model?.userId
        return coordinator.getMainView()
    }
    
    var historyVc: VaccineViewController {
        guard let nav = self.navigationController else {return VaccineViewController()}
        let coordinator = VaccineCoordinator.init(navigationController: nav)
        coordinator.vaccineType = .history
        coordinator.id = self.model?.userId
        return coordinator.getMainView()
    }
    
    var calenderVc: ImmunizationCalendarViewController {
        guard let nav = self.navigationController else {return ImmunizationCalendarViewController()}
        let coordinator = ImmunizationCalendarCoordinator.init(navigationController: nav)
        return coordinator.getMainView()
    }
    
    var model: VaccinationInfo? {
        didSet {
            self.setupDatw()
            self.currentImmunizationView = .vaccine
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: Notification.Name.init("IMMUNIZATION_DONE"), object: nil)
        self.navigationItem.title = "Immunization"
        
        viewModel.fetchVaccinationList()
        
        viewModel.models.bind { model in
            self.model = model
        }
        
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        
        viewModel.loading.bind { status in
            status ?? false ? self.showProgressHud() : self.hideProgressHud()
        }
    }
    
    @objc func update() {
        viewModel.fetchVaccinationList()
    }
    
    func setupDatw() {
        self.childName.text = model?.name
        self.childAge.text = "\(model?.age ?? "") | \(model?.dateOfBirth ?? "")"
        self.upcommingVaccinationName.text = model?.upcomingVaccinationList?.first?.vaccinationName
        self.vaccinationFor.text = model?.upcomingVaccinationList?.first?.description
        self.vaccinationDaysLeft.text = model?.upcomingVaccinationList?.first?.daysLeft?.components(separatedBy: " ").first
    }

    func setup() {
        self.currentImmuContainer.setStandardShadow()
        self.currentImmuContainer.addCornerRadius(12)
        self.backImage.addCornerRadius(12)
        self.gradientView.addCornerRadius(12)
        self.backgroundsView.addCornerRadius(12)
        self.gradientView.setGradientLeftRightNoExtra(UIColor.black, endColor: UIColor.init(hex: "22D7F2"))
        self.backgroundsView.addBorder(UIColor.lightGray.withAlphaComponent(0.2))
        
        profileImageLabel.addCornerRadius(25)
        
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
        self.currentImmunizationView = .vaccine
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
        self.currentImmunizationView = .history
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
        self.currentImmunizationView = .calendar
    }
}
