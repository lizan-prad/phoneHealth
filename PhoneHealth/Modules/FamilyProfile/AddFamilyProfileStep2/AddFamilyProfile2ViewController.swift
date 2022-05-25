//
//  AddFamilyProfile2ViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 27/02/2022.
//

import UIKit
import MBRadioCheckboxButton
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class AddFamilyProfile2ViewController: UIViewController, Storyboarded {

    @IBOutlet weak var allergyContainer: UIView!
    @IBOutlet weak var diseaseContainer: UIView!
    @IBOutlet weak var selectAllergy: UILabel!
    @IBOutlet weak var selectDisease: UILabel!
    @IBOutlet weak var chronicNo: RadioButton!
    @IBOutlet weak var chronicYes: RadioButton!
    
    @IBOutlet weak var alleryYes: RadioButton!
    @IBOutlet weak var allergyNo: RadioButton!
    
    @IBOutlet weak var diseaseCollection: UICollectionView!
    @IBOutlet weak var allergyColleciton: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var otherField: MDCOutlinedTextField!
    @IBOutlet weak var otherAllergyField: MDCOutlinedTextField!
    @IBOutlet weak var setupoLater: UIButton!
    
    @IBOutlet weak var diseaseColHeight: NSLayoutConstraint!
    @IBOutlet weak var allergyColHeight: NSLayoutConstraint!
    
    var selectedAllergies = [DynamicUserDataModel]()
    var selectedDiseases = [DynamicUserDataModel]()
    
    var allergies: [DynamicUserDataModel]? {
        didSet {
            allergyColHeight.constant = CGFloat(((self.allergies?.count ?? 0))*48)
            self.allergyColleciton.reloadData()
        }
    }
    
    var chronics: [DynamicUserDataModel]? {
        didSet {
            diseaseColHeight.constant = CGFloat(((self.chronics?.count ?? 0)/2)*50)
            self.diseaseCollection.reloadData()
        }
    }
    
    var viewModel: AddFamilyProfile2ViewModel!
    
    var model: UserProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Family Profle Other"
        setupView()
        setupCollection()
        self.bindViewModel()
        
        self.viewModel.fetchDiseases()
        self.viewModel.fetchAllergies()
        diseaseContainer.layer.cornerRadius = 12
        allergyContainer.layer.cornerRadius = 12
        
        diseaseContainer.addBorder(ColorConfig.baseColor.withAlphaComponent(0.2))
        allergyContainer.addBorder(ColorConfig.baseColor.withAlphaComponent(0.2))
        
        self.alleryYes.isOn = true
        alleryYes.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        alleryYes.tintColor = ColorConfig.baseColor
        allergyNo.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        allergyNo.tintColor = ColorConfig.baseColor
        alleryYes.addTarget(self, action: #selector(didChangeAllergyRadioBtn(_:)), for: .touchUpInside)
        allergyNo.addTarget(self, action: #selector(didChangeAllergyRadioBtn(_:)), for: .touchUpInside)
        
        self.chronicYes.isOn = true
        chronicYes.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        chronicYes.tintColor = ColorConfig.baseColor
        chronicNo.radioButtonColor = RadioButtonColor.init(active: ColorConfig.baseColor, inactive: UIColor.lightGray)
        chronicNo.tintColor = ColorConfig.baseColor
        chronicYes.addTarget(self, action: #selector(didChangeChronicRadioBtn(_:)), for: .touchUpInside)
        chronicNo.addTarget(self, action: #selector(didChangeChronicRadioBtn(_:)), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(proceedToConfirmation), for: .touchUpInside)
        
        if let model = self.model {
            self.selectedAllergies = model.userAllergyInfo?.compactMap({ model in
                var dict: [String: Any] = [:]
                dict["code"] = model.userAllergyInfoId
                dict["label"] = model.allergyName
                dict["value"] = model.allergyId
                dict["status"] = "Y"
                return DynamicUserDataModel.init(JSON: dict)
            }) ?? []
            
            self.selectedDiseases = model.userDiseaseInfo?.compactMap({ model in
                var dict: [String: Any] = [:]
                dict["code"] = model.userDiseaseInfoId
                dict["label"] = model.diseaseName
                dict["value"] = model.diseaseId
                dict["status"] = "Y"
                return DynamicUserDataModel.init(JSON: dict)
            }) ?? []
        }
    }
    
    @objc func proceedToConfirmation() {
        let healthModel = self.viewModel.model
        healthModel?.haveAllergies = self.alleryYes.isOn ? "Y" : "N"
        healthModel?.haveCronicDease = self.chronicYes.isOn ? "Y" : "N"
        healthModel?.userAllergyInfo = self.selectedAllergies.map({AllergyDetailModel.init(allergyId: $0.value, allergyName: $0.label, isPrimary: "N", status: "Y", info: $0.code)}) + (self.allergies?.filter({!self.selectedAllergies.compactMap({$0.value}).contains($0.value ?? 0)}).map({AllergyDetailModel.init(allergyId: $0.value, allergyName: $0.label, isPrimary: "N", status: "N", info: $0.code ?? 0)}) ?? [])
        healthModel?.userDiseaseInfo = self.selectedDiseases.map({DiseaseDetailModel.init(diseaseId: $0.value, diseaseName: $0.label, isPrimary: "N", status: "Y", info: $0.code)}) + (self.chronics?.filter({!self.selectedDiseases.compactMap({$0.value}).contains($0.value ?? 0)}).map({DiseaseDetailModel.init(diseaseId: $0.value, diseaseName: $0.label, isPrimary: "N", status: "N")}) ?? [])
        guard let nav = self.navigationController else {return}
        let coordinator = FamilyProfileConfirmationCoordinator.init(navigationController: nav, model: healthModel)
        coordinator.userProfile = self.model
        coordinator.start()
    }
    
    func bindViewModel() {
        self.viewModel.cronics.bind { models in
            self.chronics = models
        }
        
        self.viewModel.allergies.bind { models in
            self.allergies = models
        }
        
        self.viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    @objc func didChangeAllergyRadioBtn(_ sender: RadioButton) {
        self.nextBtn.isEnabled = validate()
        switch sender {
        case alleryYes:
            self.alleryYes.isOn = true
            self.allergyNo.isOn = false
            self.allergyColleciton.isHidden = false
            self.selectAllergy.isHidden = false
        case allergyNo:
            self.selectedAllergies = []
            self.allergyColleciton.reloadData()
            self.allergyNo.isOn = true
            self.alleryYes.isOn = false
            self.allergyColleciton.isHidden = true
            self.selectAllergy.isHidden = true
        default:
            break
        }
    }
    
    @objc func didChangeChronicRadioBtn(_ sender: RadioButton) {
        self.nextBtn.isEnabled = validate()
        switch sender {
        case chronicYes:
            self.chronicYes.isOn = true
            self.chronicNo.isOn = false
            self.diseaseCollection.isHidden = false
            self.selectDisease.isHidden = false
        case chronicNo:
            self.selectedDiseases = []
            self.diseaseCollection.reloadData()
            self.chronicNo.isOn = true
            self.chronicYes.isOn = false
            self.diseaseCollection.isHidden = true
            self.selectDisease.isHidden = true
        default:
            break
        }
    }
    
    func validate() -> Bool {
        return ((alleryYes.isOn && selectedAllergies.count != 0) || allergyNo.isOn) && ((chronicYes.isOn && selectedDiseases.count != 0) || (chronicNo.isOn))
    }
    
    func setupCollection() {
        diseaseCollection.dataSource = self
        diseaseCollection.delegate = self
        
        allergyColleciton.dataSource = self
        allergyColleciton.delegate = self
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        diseaseCollection.collectionViewLayout = layout
        diseaseCollection.register(UINib.init(nibName: "AddFamilyDiseaseAllergyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddFamilyDiseaseAllergyCollectionViewCell")
        allergyColleciton.register(UINib.init(nibName: "AddFamilyDiseaseAllergyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddFamilyDiseaseAllergyCollectionViewCell")
    }
    
    func setupView() {
        backBtn.addBorder(UIColor.lightGray.withAlphaComponent(0.6))
        nextBtn.rounded()
        backBtn.rounded()
        
        setupoLater.setAttributedTitle("Skip Profile Update".getAtrribText(), for: .normal)
        
        backBtn.setAttributedTitle("Back".getAtrribText(), for: .normal)
        nextBtn.setAttributedTitle("Next".getAtrribText(), for: .normal)
        chronicYes.setTitle("", for: .normal)
        chronicNo.setTitle("", for: .normal)
        
        alleryYes.setTitle("", for: .normal)
        allergyNo.setTitle("", for: .normal)
        
        otherField.setup("Other Disease")
        otherAllergyField.setup("Other")
    }
    


}

extension AddFamilyProfile2ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case diseaseCollection:
            return chronics?.count ?? 0
        case allergyColleciton:
            return allergies?.count ?? 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case diseaseCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFamilyDiseaseAllergyCollectionViewCell", for: indexPath) as! AddFamilyDiseaseAllergyCollectionViewCell
            cell.namelbael.text = self.chronics?[indexPath.row].label
            if self.selectedDiseases.map({$0.label ?? ""}).contains(cell.namelbael.text ?? "") {
                cell.contentView.backgroundColor = ColorConfig.baseColor.withAlphaComponent(0.4)
            } else {
                cell.contentView.backgroundColor = .white
            }
            cell.index = indexPath.row
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.addBorder(UIColor.lightGray.withAlphaComponent(0.3))
            return cell
        case allergyColleciton:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFamilyDiseaseAllergyCollectionViewCell", for: indexPath) as! AddFamilyDiseaseAllergyCollectionViewCell
            cell.namelbael.text = self.allergies?[indexPath.row].label
            cell.index = indexPath.row
            if self.selectedAllergies.map({$0.label ?? ""}).contains(cell.namelbael.text ?? "") {
                cell.contentView.backgroundColor = ColorConfig.baseColor.withAlphaComponent(0.4)
            } else {
                cell.contentView.backgroundColor = .clear
            }
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.addBorder(UIColor.lightGray.withAlphaComponent(0.3))
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case diseaseCollection:
            let cell = collectionView.cellForItem(at: indexPath) as! AddFamilyDiseaseAllergyCollectionViewCell
            if selectedDiseases.map({$0.value ?? 0}).contains((self.chronics?[cell.index ?? 0].value ?? 0)) {
                let index = selectedDiseases.firstIndex { b in
                    return b.value == (self.chronics?[cell.index ?? 0].value ?? 0)
                }
                cell.contentView.backgroundColor = .white
                let m = selectedDiseases[index ?? 0]
                m.status = "N"
                let index2 = chronics?.firstIndex { b in
                    return b.value == m.value
                }
                self.chronics?.insert(m, at: index2 ?? 0)
                self.chronics?.remove(at: (index2 ?? 0) + 1)
                self.selectedDiseases.remove(at: index ?? 0)
                return
            }
            cell.contentView.backgroundColor = ColorConfig.baseColor.withAlphaComponent(0.4)
            guard let disease = self.chronics?[indexPath.row] else {return}
            disease.status = "Y"
            self.selectedDiseases.append(disease)
        case allergyColleciton:
            let cell = collectionView.cellForItem(at: indexPath) as! AddFamilyDiseaseAllergyCollectionViewCell
            if selectedAllergies.map({$0.value ?? 0}).contains((self.allergies?[cell.index ?? 0].value ?? 0)) {
                let index = selectedAllergies.firstIndex { b in
                    return b.value == (self.allergies?[cell.index ?? 0].value ?? 0)
                }
                cell.contentView.backgroundColor = .white
                let m = selectedAllergies[index ?? 0]
                m.status = "N"
                let index2 = allergies?.firstIndex { b in
                    return b.value == m.value
                }
                self.allergies?.insert(m, at: index2 ?? 0)
                self.allergies?.remove(at: (index2 ?? 0) + 1)
                self.selectedAllergies.remove(at: index ?? 0)
                return
            }
            cell.contentView.backgroundColor = ColorConfig.baseColor.withAlphaComponent(0.4)
            guard let allergy = self.allergies?[indexPath.row] else {return}
            self.selectedAllergies.append(allergy)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case diseaseCollection:
            return CGSize.init(width: (chronics?[indexPath.item].label?.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width ?? 0) + 37, height: 40)
        case allergyColleciton:
            return CGSize.init(width:  self.allergyColleciton.frame.width - 20, height: 40)
        default: return CGSize.init(width: 0, height: 0)
        }
    }
}
