//
//  UpdateProfileViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 08/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import Alamofire

class UpdateProfileViewController: UIViewController, Storyboarded {

    @IBOutlet weak var wardNumberField: MDCOutlinedTextField!
    @IBOutlet weak var vdcField: MDCOutlinedTextField!
    @IBOutlet weak var districtField: MDCOutlinedTextField!
    @IBOutlet weak var provinceField: MDCOutlinedTextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var uploadImageBtn: UIButton!
    @IBOutlet weak var genderField: MDCOutlinedTextField!
    @IBOutlet weak var adbsField: MDCOutlinedTextField!
    @IBOutlet weak var yearField: MDCOutlinedTextField!
    @IBOutlet weak var monthField: MDCOutlinedTextField!
    @IBOutlet weak var dayFIeld: MDCOutlinedTextField!
    
    @IBOutlet weak var emailAddressField: MDCOutlinedTextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var viewModel: UpdateProfileViewModel!

    
    var genders = [("Male","M"), ("Female","F"), ("Others","O")]
    var ADBS = ["AD", "BS"]
    var province: [ProvinceModel]? {
        didSet {
            provincePicker.reloadAllComponents()
        }
    }
    
    var selectedGender: (String,String)? {
        didSet {
            self.genderField.text = selectedGender?.0
        }
    }
    
    var districts: [ProvinceModel]? {
        didSet {
            districtPicker.reloadAllComponents()
        }
    }
    
    var vdcs: [ProvinceModel]? {
        didSet {
            vdcPicker.reloadAllComponents()
        }
    }
    
    let vdcPicker = UIPickerView()
    let provincePicker = UIPickerView()
    let districtPicker = UIPickerView()
    let pickerView = UIPickerView()
    let genderPickerView = UIPickerView()
    
    var updateProfileDetails: UpdateProfileStruct?
    var selectedVDC: ProvinceModel? {
        didSet {
            self.vdcField.text = selectedVDC?.label
        }
    }
    
    var selectedProvince: ProvinceModel? {
        didSet {
            self.provinceField.text = selectedProvince?.label
            viewModel.fetchDistrict(provinceId: selectedProvince?.value ?? 0)
        }
    }
    
    var selectedDistrict: ProvinceModel? {
        didSet {
            self.districtField.text = selectedDistrict?.label
            viewModel.fetchMunicipality(districtId: selectedDistrict?.value ?? 0)
        }
    }
    var selectedImage: UIImage? {
        didSet {
            self.profileImage.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        pickerView.dataSource = self
        pickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        provincePicker.dataSource = self
        provincePicker.delegate = self
        districtPicker.dataSource = self
        districtPicker.delegate = self
        vdcPicker.dataSource = self
        vdcPicker.delegate = self
        
        
        if let model = self.viewModel.model {
            self.navigationItem.title = "Update Profile"
            self.setupData(model: model)
        }
        self.navigationItem.title = "Setup Profile"
        self.viewModel.fetchProvince()
        uploadImageBtn.addTarget(self, action: #selector(openCameraAction), for: .touchUpInside)
    }
    
    @objc func openCameraAction() {
        let imageManager = ImagePickerManager()
        imageManager.userCustomCamera = false
        imageManager.pickImage(self){ image in
            self.selectedImage = image
        }
    }
    
    func setupData(model: UserProfileModel?) {
        self.profileImage.sd_setImage(with: URL.init(string: model?.avatar ?? "")) { img, error, _,_ in
        
            self.profileImage.image = img
        }
        self.selectedGender = (model?.gender?.capitalized ?? "", "\((model?.gender ?? "").first ?? Character.init("M"))")
        self.selectedImage = self.profileImage.image
        self.emailAddressField.text = model?.email
        self.yearField.text = model?.dateOfBirth?.components(separatedBy: "-").first
        self.monthField.text = model?.dateOfBirth?.components(separatedBy: "-")[1]
        self.dayFIeld.text = model?.dateOfBirth?.components(separatedBy: "-").last
        self.adbsField.text = "AD"
        self.wardNumberField.text = model?.wardNumber ?? ""
    }
    
    
    func bindViewModel() {
        viewModel.provinceList.bind { models in
            self.province = models
            if self.viewModel.model != nil {
                self.selectedProvince = self.province?.filter({$0.value == self.viewModel?.model?.provinceId}).first
            }
        }
        viewModel.districtList.bind { models in
            self.districts = models
            if self.viewModel.model != nil {
                self.selectedDistrict = self.districts?.filter({$0.value == self.viewModel?.model?.districtId}).first
            }
        }
        
        viewModel.vdcList.bind { models in
            self.vdcs = models
            if self.viewModel.model != nil {
                self.selectedVDC = self.vdcs?.filter({$0.value == self.viewModel?.model?.vdcOrMunicipalityId}).first
            }
        }
        viewModel.success.bind { status in
            if self.viewModel.model == nil {
            guard let navigationController = self.navigationController, let model = self.updateProfileDetails else {return}
            let coodinator = UserSteppingCoordinator.init(navigationController: navigationController, model: model)
            coodinator.start()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView() {
        dayFIeld.keyboardType = .numberPad
        yearField.keyboardType = .numberPad
        monthField.keyboardType = .numberPad
        wardNumberField.keyboardType = .numberPad
        emailAddressField.keyboardType = .emailAddress
        self.nextBtn.isEnabled = false
        uploadImageBtn.addCornerRadius(8)
        
        adbsField.inputView = pickerView
        genderField.inputView = genderPickerView
        provinceField.inputView = provincePicker
        districtField.inputView = districtPicker
        vdcField.inputView = vdcPicker
        
        nextBtn.addCornerRadius(12)
        profileImage.addCornerRadius(profileImage.frame.height/2)
        uploadImageBtn.addCornerRadius(8)
        genderField.setup("Gender")
        adbsField.setup("AD/BS")
        yearField.setup("Year")
        monthField.setup("Month")
        dayFIeld.setup("Day")
        provinceField.setup("Province")
        districtField.setup("District")
        vdcField.setup("VDC/Municipality")
        wardNumberField.setup("WardNumber")
        emailAddressField.setup("Email Address")
        nextBtn.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        
        dayFIeld.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        monthField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        yearField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        provinceField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        districtField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        vdcField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        wardNumberField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        emailAddressField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
    }
    
    @objc func textChanged(_ sender: MDCOutlinedTextField) {
        nextBtn.isEnabled = validateForm()
        switch sender {
        case dayFIeld:
            dayFIeld.setOutlineColor(dayFIeld.text == "" ? .red : .lightGray, for: .normal)
            dayFIeld.setOutlineColor(dayFIeld.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case monthField:
            monthField.setOutlineColor(monthField.text == "" ? .red : .lightGray, for: .normal)
            monthField.setOutlineColor(monthField.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case yearField:
            yearField.setOutlineColor(yearField.text == "" ? .red : .lightGray, for: .normal)
            yearField.setOutlineColor(yearField.text == "" ? .red : ColorConfig.baseColor, for: .editing)
        case provinceField:
            provinceField.leadingAssistiveLabel.text = provinceField.text == "" ? "Select your address" : ""
        case districtField:
            districtField.leadingAssistiveLabel.text = districtField.text == "" ? "Select your district" : ""
        case vdcField:
            vdcField.leadingAssistiveLabel.text = vdcField.text == "" ? "Select your VDC/Municipality" : ""
        case wardNumberField:
            wardNumberField.leadingAssistiveLabel.text = wardNumberField.text == "" ? "Enter your ward number" : ""
        case emailAddressField:
            emailAddressField.leadingAssistiveLabel.text = emailAddressField.text == "" ? "Enter your email address" : ""
        default:
            break
        }
    }
    
    func validateForm() -> Bool {
        adbsField.setOutlineColor(adbsField.text == "" ? .red : .lightGray, for: .normal)
        genderField.leadingAssistiveLabel.text = genderField.text == "" ? "Select Gender" : ""
        return (genderField.text != "" && adbsField.text != "" && dayFIeld.text != "" && monthField.text != "" && yearField.text != "" && provinceField.text != "" && districtField.text != "" && vdcField.text != "" && wardNumberField.text != "" && emailAddressField.text != "")
    }
    
    @objc func actionNext() {
        let dob = "\(self.yearField.text ?? "")-\(self.monthField.text ?? "")-\(self.dayFIeld.text ?? "") \(self.adbsField.text ?? "")"
        let imageURI = "IMG_\(Int(Date().timeIntervalSince1970)).jpeg"
        var model = UpdateProfileStruct.init(avatar: URLConfig.minioBase + "\(UserDefaults.standard.value(forKey: "Mobile") as! String)/profileImage/\(imageURI)", dob: dob, districtId: selectedDistrict?.value ?? 0, email: emailAddressField.text, gender: selectedGender?.1 ?? "", province: selectedProvince?.value ?? 0, vdc: selectedVDC?.value ?? 0, wardNumber: wardNumberField.text ?? "")
        model.address = "\(self.selectedDistrict?.label ?? ""), \(wardNumberField.text ?? "")"
        self.updateProfileDetails = model
        let param = ["fileName": URLConfig.minioBase + "\(UserDefaults.standard.value(forKey: "Mobile") as? String ?? "")/profileImage/\(imageURI)"]
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
                        self.viewModel.updateprofile(model: model)
                    }
                }
            case .failure( _):
                break
            }
            
        }
    }

}



extension UpdateProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case vdcPicker:
            return self.vdcs?.count ?? 0
        case districtPicker:
            return self.districts?.count ?? 0
        case provincePicker:
            return self.province?.count ?? 0
        case genderPickerView:
            return genders.count
        case self.pickerView:
            return ADBS.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case vdcPicker:
            return vdcs?[row].label
        case districtPicker:
            return districts?[row].label
        case provincePicker:
            return province?[row].label
        case genderPickerView:
            return genders[row].0
        case self.pickerView:
            return ADBS[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case vdcPicker:
            self.selectedVDC = vdcs?[row]
        case districtPicker:
            self.selectedDistrict = districts?[row]
        case provincePicker:
            self.selectedProvince = province?[row]
        case genderPickerView:
            self.selectedGender = genders[row]
        case self.pickerView:
            self.adbsField.text = ADBS[row]
        default:
            break
        }
    }
}

