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
    
    var model: UserProfileModel? {
        didSet {
            setupData()
            self.tableView.reloadData()
        }
    }
    
    var healthLockerList: [HealthLockerListModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.navigationItem.title = "Family Profile"
        self.setupNav()
        self.bindViewModel()
        setupTableView()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchProfile()
        self.viewModel.searchHealthLocker()
    }
    
    func bindViewModel() {
        self.viewModel.healthLocker.bind { model in
            self.healthLockerList = model
        }
        self.viewModel.success.bind { model in
            self.model = model
        }
        self.viewModel.loading.bind { status in
            if status ?? false {
                self.showProgressHud()
            } else {
                self.hideProgressHud()
            }
        }
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
    }
    
    func setupData() {
        self.nameLabel.text = "ID: \(model?.id ?? 0)"
        self.genderLabel.text = model?.gender?.capitalized
        self.idLabel.text = model?.name
        self.locationLabel.text = model?.districtName
        self.emailLabel.text = model?.email
        self.dobLabel.text = model?.dateOfBirth
        self.profileImageLabel.sd_setImage(with: URL.init(string: model?.avatar ?? ""))
    }
    
    func setupNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.init(hex: "F5FAFA")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorConfig.baseColor]
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorConfig.baseColor]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
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
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
//                self.cardHeight.constant = (scrollView.contentOffset.y > 0) ? 0 : 162
                self.cardView.isHidden = (scrollView.contentOffset.y > 0)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
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
        if section == 2 {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentHealthSection == .allergies || currentHealthSection == .diseases {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyHealthAllergiesTableViewCell") as! FamilyHealthAllergiesTableViewCell
            
            cell.section = currentHealthSection == .allergies ? 2 : 3
            cell.allergiesLabel.text = currentHealthSection == .allergies ? model?.userAllergyInfo : model?.userDiseaseInfo
            cell.setup()
            return cell
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserBasicInfoTableViewCell") as! UserBasicInfoTableViewCell
            cell.setup()
            cell.model = self.model
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyHealthLockerTableViewCell") as! FamilyHealthLockerTableViewCell
            cell.setup()
            cell.models = self.healthLockerList
            cell.didTapAdd = {
                guard let nav = self.navigationController else {return}
                let coordinator = HealthLockerCoordinator.init(navigationController: nav)
                let vc = coordinator.getMainView()
                vc.isFamily = true
                vc.familyId = self.model?.id
                self.present(vc , animated: true, completion: nil)
            }
            
            cell.didTapOpen = { model in
                let vc = UIStoryboard.init(name: "Scan", bundle: nil).instantiateViewController(withIdentifier: "ScanViewController") as! ScanViewController
                vc.image = model
                self.present(vc, animated: true, completion: nil)
            }
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
        case 1:
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
