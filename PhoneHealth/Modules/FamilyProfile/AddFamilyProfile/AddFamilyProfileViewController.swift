//
//  AddFamilyProfileViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 27/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import Alamofire

struct FmailyProfileStruct {
    
    var avatar: String?
    var dateOfBirth: String?
    var districtId: Int?
    var email: String?
    var gender: String?
    var provinceId: Int?
    var fullName: String?
    var relationId: Int?
    var vdcOrMunicipalityId: Int?
    var wardNumber: String?
}

class AddFamilyProfileViewController: UIViewController, Storyboarded {

    @IBOutlet weak var nextnt: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var relationField: MDCOutlinedTextField!
    @IBOutlet weak var fullName: MDCOutlinedTextField!
    @IBOutlet weak var gender: MDCOutlinedTextField!
    @IBOutlet weak var adbs: MDCOutlinedTextField!
    @IBOutlet weak var year: MDCOutlinedTextField!
    @IBOutlet weak var month: MDCOutlinedTextField!
    @IBOutlet weak var day: MDCOutlinedTextField!
    @IBOutlet weak var bloodGroup: MDCOutlinedTextField!
    @IBOutlet weak var feet: MDCOutlinedTextField!
    @IBOutlet weak var inch: MDCOutlinedTextField!
    @IBOutlet weak var weight: MDCOutlinedTextField!
    
    var viewModel: AddFamilyProfileViewModel!
    
    var isChild: Bool = false
    
    var model: UserProfileModel?
    
    let relationPickerView = UIPickerView()
    let genderPickerView = UIPickerView()
    let adbsPickerView = UIPickerView()
    var pickerBlood = UIPickerView()
    var pickerFeet = UIPickerView()
    var pickerInches = UIPickerView()
    var pickerKG = UIPickerView()
    
    var feetData = [String]()
    var inchesData = [String]()
    var kgData = [String]()
    
    var relations: [DynamicUserDataModel]? {
        didSet {
            self.relationPickerView.reloadAllComponents()
        }
    }
    
    var familyStruct: FmailyProfileStruct?
    
    var selectedRelation: DynamicUserDataModel? {
        didSet {
            self.relationField.text = selectedRelation?.label
        }
    }
    
    var selectedGender: (String,String)? {
        didSet {
            self.gender.text = selectedGender?.0
        }
    }
    
    var bloodGroups: [DynamicUserDataModel]? {
        didSet {
            pickerBlood.reloadAllComponents()
        }
    }
    
    var selectedBloodGroup: DynamicUserDataModel? {
        didSet {
            bloodGroup.text = selectedBloodGroup?.label
        }
    }
    
    var genders = [("Male","M"), ("Female","F"), ("Others","O")]
    var ADBS = ["AD", "BS"]
    
    var selectedImage: UIImage? {
        didSet {
            self.profileImage.image = selectedImage
        }
    }
    
    var userProfileModel: UserProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeild()
        setupView()
        bindViewModel()
        self.title = isChild ? "Add Immunization Profile": "Add Family Profile"
        self.relationField.isEnabled = !isChild
        self.viewModel.fetchRelations()
        self.viewModel.fetchBloodGroups()
        self.viewModel.fetchProfile()
        feetData = (0 ..< 8).map({"\($0)"})
        inchesData = (0 ..< 13).map({"\($0)"})
        kgData = (0 ..< 200).map({"\($0)"})
        nextnt.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextnt.isEnabled = false
        
       
        profileImage.addCornerRadius(profileImage.frame.height/2)
        
        uploadBtn.addTarget(self, action: #selector(openCameraAction), for: .touchUpInside)
        
    }
    
    func setupData(model: UserProfileModel?) {
        self.profileImage.sd_setImage(with: URL.init(string: model?.avatar ?? "")) { img, error, _,_ in
        
            self.profileImage.image = img
        }
        
        
        self.fullName.text = model?.name
        self.selectedRelation = self.relations?.filter({$0.value == model?.relationId}).first
        self.selectedBloodGroup = self.bloodGroups?.filter({$0.value == model?.bloodGroupId}).first
        self.selectedGender = (model?.gender?.capitalized ?? "", "\((model?.gender ?? "").first ?? Character.init("M"))")
        self.selectedImage = self.profileImage.image
//        self..text = model?.email
        self.year.text = model?.dateOfBirth?.components(separatedBy: "-").first
        self.month.text = model?.dateOfBirth?.components(separatedBy: "-")[1]
        self.day.text = model?.dateOfBirth?.components(separatedBy: "-").last
        self.adbs.text = "AD"
        self.inch.text = "\(model?.height ?? 0)".components(separatedBy: ".").last
        self.feet.text = "\(model?.height ?? 0)".components(separatedBy: ".").first
        self.weight.text = "\(model?.weight ?? 0)"
//        self..text = model?.wardNumber ?? ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.nextnt.isEnabled = self.validateForm()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Add Family Profile"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    @objc func openCameraAction() {
        let imageManager = ImagePickerManager()
        imageManager.userCustomCamera = false
        imageManager.pickImage(self){ image in
            self.selectedImage = image
        }
    }
    
   
    
    @objc func nextAction() {
        let dob = "\(self.year.text ?? "")-\(self.month.text ?? "")-\(self.day.text ?? "") \(self.adbs.text ?? "")"
        let imageURI = "IMG_\(Int(Date().timeIntervalSince1970)).jpeg"
        let model = FmailyProfileStruct.init(avatar: self.selectedImage == nil ? "" : URLConfig.minioBase + "\(UserDefaults.standard.value(forKey: "Mobile") as! String)/family/profileImage/\(imageURI)", dateOfBirth: dob, districtId: userProfileModel?.districtId, email: userProfileModel?.email, gender: self.selectedGender?.1, provinceId: self.userProfileModel?.provinceId, fullName: fullName.text, relationId: self.selectedRelation?.value, vdcOrMunicipalityId: self.userProfileModel?.vdcOrMunicipalityId, wardNumber: "\(self.userProfileModel?.wardNumber ?? "")")
        self.familyStruct = model
        if self.selectedImage == nil {
            if self.model == nil {
                self.viewModel.updateprofile(model: model)
            } else {
                self.viewModel.updateFamilyprofile(model: model, userId: self.model?.id ?? 0)
            }
        } else {
            let param = ["fileName": URLConfig.minioBase + "\(UserDefaults.standard.value(forKey: "Mobile") as? String ?? "")/family/profileImage/\(imageURI)"]
            self.showProgressHud()
            MinioManager.shared.requestMinioUrl(param: param, encoding: JSONEncoding.default, headers: nil) { result in
                switch result {
                case .success(let url):
                    if let url = URL.init(string: url) {
                        var request = URLRequest.init(url: url)
                        request.method = .put
                        request.headers = ["Content-Type": "image/jpeg"]
                        guard let body = self.selectedImage?.jpegData(compressionQuality: 0.3) else { return }
                        request.httpBody = body
                        AF.request(request).response { response in
                            self.hideProgressHud()
                            if self.model == nil {
                                self.viewModel.updateprofile(model: model)
                            } else {
                                self.viewModel.updateFamilyprofile(model: model, userId: self.model?.id ?? 0)
                            }
                        }
                    }
                case .failure( _):
                    break
                }
                
            }
        }
        
    }
    
    func bindViewModel() {
        viewModel.model.bind { model in
            self.userProfileModel = model
        }
        viewModel.relations.bind { models in
            self.relations =  self.isChild ? models?.filter({$0.label?.lowercased() == "child"}) : models
            if self.isChild {
                self.selectedRelation = self.relations?.first
            }
            if let model = self.model {
                self.setupData(model: model)
            }
            
        }
        viewModel.bloodGroups.bind { models in
            self.bloodGroups = models
            if let model = self.model {
                self.setupData(model: model)
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
        viewModel.success.bind { msg in
            self.showAlert(title: nil, message: self.model == nil ? "Your family profile has been created." : "Your family profile has been updated.") { _ in
                if self.isChild {
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                guard let nav = self.navigationController else {return}
                let model = HealthProfileModel()
                model.avatar = self.profileImage.image
                model.familyData = self.familyStruct
                model.userId = msg
                model.weight = self.weight.text
                model.height = "\(self.feet.text ?? "").\(self.inch.text ?? "")"
                model.bloodGroup = self.selectedBloodGroup?.label
                model.bloodGroupId = self.selectedBloodGroup?.value ?? 0
                let coordinator = AddFamilyProfile2Coordinator.init(navigationController: nav)
                coordinator.model = model
                coordinator.updateProfile = self.model
                coordinator.start()
            }
        }
    }
    
    func setupFeild() {
        relationField.setup("Relation")
        fullName.setup("Full Name")
        gender.setup("Gender")
        adbs.setup("AD/BS")
        year.setup("Year")
        month.setup("Month")
        day.setup("Day")
        bloodGroup.setup("Blood Group")
        feet.setup("Feet")
        inch.setup("Inches")
        weight.setup("KG")
    }
    
    func setupView() {
        nextnt.layer.cornerRadius = 12
        uploadBtn.layer.cornerRadius = 6
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        
        relationPickerView.dataSource = self
        relationPickerView.delegate = self
        
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        
        adbsPickerView.dataSource = self
        adbsPickerView.delegate = self
        
        pickerBlood.dataSource = self
        pickerBlood.delegate = self
        
        pickerFeet.dataSource = self
        pickerFeet.delegate = self
        
        pickerInches.dataSource = self
        pickerInches.delegate = self
        
        pickerKG.dataSource = self
        pickerKG.delegate = self
        
        bloodGroup.inputView = pickerBlood
        feet.inputView = pickerFeet
        inch.inputView = pickerInches
        weight.inputView = pickerKG
        relationField.inputView = relationPickerView
        gender.inputView = genderPickerView
        adbs.inputView = adbsPickerView
        
        day.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        month.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        year.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        fullName.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
       
        relationField.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        adbs.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        gender.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        bloodGroup.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        feet.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        inch.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        weight.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
    }
    
    @objc func valueChanged() {
        nextnt.isEnabled = validateForm()
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        nextnt.isEnabled = validateForm()
        switch sender {
        case day:
            day.setOutlineColor(day.text == "" ? .red : .lightGray, for: .normal)
            day.setOutlineColor(day.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case month:
            month.setOutlineColor(month.text == "" ? .red : .lightGray, for: .normal)
            month.setOutlineColor(month.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case year:
            year.setOutlineColor(year.text == "" ? .red : .lightGray, for: .normal)
            year.setOutlineColor(year.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case fullName:
            fullName.leadingAssistiveLabel.text = fullName.text == "" ? "Enter your Full Name" : ""
        default:
            break
        }
    }
    
    func validateForm() -> Bool {
        adbs.setOutlineColor(adbs.text == "" ? .red : .lightGray, for: .normal)
        gender.leadingAssistiveLabel.text = gender.text == "" ? "Select Gender" : ""
        relationField.leadingAssistiveLabel.text = relationField.text == "" ? "Select Relation" : ""
        bloodGroup.leadingAssistiveLabel.text = bloodGroup.text == "" ? "Select Blood Group" : ""
        feet.leadingAssistiveLabel.text = feet.text == "" ? "Select Feet" : ""
        inch.leadingAssistiveLabel.text = inch.text == "" ? "Select Inches" : ""
        weight.leadingAssistiveLabel.text = weight.text == "" ? "Select KG" : ""
        return (gender.text != "" && adbs.text != "" && day.text != "" && month.text != "" && year.text != "" && bloodGroup.text != "" && feet.text != "" && inch.text != "" && weight.text != "" && fullName.text != "" && relationField.text != "")
    }

}

extension AddFamilyProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case genderPickerView:
            return genders.count
        case relationPickerView:
            return relations?.count ?? 0
        case adbsPickerView:
            return ADBS.count
        case pickerBlood:
            return bloodGroups?.count ?? 0
        case pickerFeet:
            return feetData.count
        case pickerInches:
            return inchesData.count
        case pickerKG:
            return kgData.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case genderPickerView:
            return genders[row].0
        case relationPickerView:
            return relations?[row].label
        case self.adbsPickerView:
            return ADBS[row]
        case pickerBlood:
            return bloodGroups?[row].label
        case pickerFeet:
            return feetData[row]
        case pickerInches:
            return inchesData[row]
        case pickerKG:
            return kgData[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case genderPickerView:
            self.selectedGender = genders[row]
        case adbsPickerView:
            self.adbs.text = ADBS[row]
        case relationPickerView:
            self.selectedRelation = relations?[row]
        case pickerBlood:
            self.selectedBloodGroup = bloodGroups?[row]
        case pickerFeet:
            feet.text = feetData[row]
        case pickerInches:
            inch.text = inchesData[row]
        case pickerKG:
            weight.text = kgData[row]
        default:
            break
        }
    }
}

