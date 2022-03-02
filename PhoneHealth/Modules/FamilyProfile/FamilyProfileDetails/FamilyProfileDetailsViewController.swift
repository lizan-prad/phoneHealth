//
//  FamilyProfileDetailsViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit

class FamilyProfileDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var cardHeight: NSLayoutConstraint!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var subBackground: UIView!
    @IBOutlet weak var backgroundsView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var basicLabel: UILabel!
    @IBOutlet weak var allergyLabel: UILabel!
    @IBOutlet weak var chronicLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionBackView: UIView!
    
    var viewModel: FamilyProfileDetailsViewModel!
    
    private enum HealthSection {
        case details
        case allergies
        case diseases
    }
    
    private var currentHealthSection: HealthSection = .details {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.navigationItem.title = "Family Profile"
        self.setupNav()
        setupTableView()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setupNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.init(hex: "F5FAFA")
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    func setup() {
        self.subBackground.addCornerRadius(8)
        self.backImage.addCornerRadius(12)
        self.gradientView.addCornerRadius(12)
        self.backgroundsView.addCornerRadius(12)
        self.gradientView.setGradientLeftRightNoExtra(UIColor.black, endColor: UIColor.init(hex: "22D7F2"))
        self.backgroundsView.addBorder(UIColor.lightGray.withAlphaComponent(0.2))
        
        profileImageLabel.addCornerRadius(35)
        
        profileImageLabel.addBorderwith(.white, width: 3)
        self.cardView.setStandardShadow()
        self.cardView.addCornerRadius(12)
        self.pagerView.setStandardShadow()
        self.pagerView.rounded()
        self.selectionBackView.rounded()
        
        
        basicLabel.isUserInteractionEnabled = true
        allergyLabel.isUserInteractionEnabled = true
        chronicLabel.isUserInteractionEnabled = true
        
        basicLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapBasic)))
        allergyLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapAllergy)))
        chronicLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapChronic)))
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib.init(nibName: "UserBasicInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserBasicInfoTableViewCell")
        tableView.register(UINib.init(nibName: "FamilyAppointmentsTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyAppointmentsTableViewCell")
        tableView.register(UINib.init(nibName: "FamilyHealthLockerTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyHealthLockerTableViewCell")
        tableView.register(UINib.init(nibName: "FamilyProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyProfileHeaderTableViewCell")
        tableView.register(UINib.init(nibName: "FamilyHealthAllergiesTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyHealthAllergiesTableViewCell")
        
    }
    
    @objc func didTapBasic() {
        
        UIView.animate(withDuration: 0.3) {
            //Change position of your UnderlineBar
            self.allergyLabel.textColor = .black.withAlphaComponent(0.6)
            self.chronicLabel.textColor = .black.withAlphaComponent(0.6)
            self.basicLabel.textColor = .white
            self.selectionBackView.frame = self.basicLabel.frame
            self.view.layoutIfNeeded()
        }
        self.currentHealthSection = .details
    }
    
    
    @objc func didTapAllergy() {
        
        UIView.animate(withDuration: 0.3) {
            //Change position of your UnderlineBar
            self.chronicLabel.textColor = .black.withAlphaComponent(0.6)
            self.basicLabel.textColor = .black.withAlphaComponent(0.6)
            self.allergyLabel.textColor = .white
            self.selectionBackView.frame = self.allergyLabel.frame
            self.view.layoutIfNeeded()
        }
        self.currentHealthSection = .allergies
    }
    
    @objc func didTapChronic() {
        UIView.animate(withDuration: 0.3) {
            //Change position of your UnderlineBar
            self.allergyLabel.textColor = .black.withAlphaComponent(0.6)
            self.basicLabel.textColor = .black.withAlphaComponent(0.6)
            self.chronicLabel.textColor = .white
            self.selectionBackView.frame = self.chronicLabel.frame
            self.view.layoutIfNeeded()
        }
        self.currentHealthSection = .diseases
    }
    
}

extension FamilyProfileDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y != 0 {
            
            UIView.animate(withDuration: 0.8, animations: { () -> Void in
//                self.cardHeight.constant = (scrollView.contentOffset.y > 0) ? 0 : 162
                self.cardView.isHidden = (scrollView.contentOffset.y > 0)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            
            UIView.animate(withDuration: 0.8, animations: { () -> Void in
//                self.cardHeight.constant = !(scrollView.contentOffset.y > 0) ? 0 : 162
                self.cardView.isHidden = !(scrollView.contentOffset.y > 0)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currentHealthSection == .allergies ||  currentHealthSection == .diseases {
            return UITableView.automaticDimension
        }
        switch indexPath.section {
        case 0:
            return 133
        case 1:
            return 138
        case 2:
            return 143
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if currentHealthSection == .allergies || currentHealthSection == .diseases {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentHealthSection == .allergies || currentHealthSection == .diseases {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyHealthAllergiesTableViewCell") as! FamilyHealthAllergiesTableViewCell
            cell.setup()
            cell.allergiesLabel.text = "- Dogs \n- pollen\n- nuts and dry fruits\n- plants and flowers"
            return cell
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserBasicInfoTableViewCell") as! UserBasicInfoTableViewCell
            cell.setup()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyHealthLockerTableViewCell") as! FamilyHealthLockerTableViewCell
            cell.setup()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyAppointmentsTableViewCell") as! FamilyAppointmentsTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if currentHealthSection == .allergies || currentHealthSection == .diseases {
            return 0
        }
        switch section {
        case 1,2:
            return 25
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if currentHealthSection == .allergies || currentHealthSection == .diseases {
            return nil
        }
        switch section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyProfileHeaderTableViewCell") as! FamilyProfileHeaderTableViewCell
            cell.headerTitle.text = "Health Locker"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyProfileHeaderTableViewCell") as! FamilyProfileHeaderTableViewCell
            cell.headerTitle.text = "Appointment History"
            return cell
        default:
            return nil
        }
    }
}
