//
//  SearchMedicationViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 19/03/2022.
//

import UIKit
import Alamofire
import ObjectMapper

class MedicationSearchListContainerModel: Mappable {
    
    var medicationList: [MedicationSearchListModel]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        medicationList <- map["medicineList"]
    }
}

class MedicationSearchListModel: Mappable {
    
    var brand: String?
    var name: String?
    var route: String?
    var strength: Int?
    var unit: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        brand <- map["brand"]
        name <- map["name"]
        route <- map["route"]
        strength <- map["strength"]
        unit <- map["unit"]
    }
}

class SearchMedicationViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableVie: UITableView!
    @IBOutlet weak var searchField: UITextField!
   
    var originalList: [MedicationSearchListModel]? {
        didSet {
            filteredList = originalList
        }
    }
    
    var filteredList: [MedicationSearchListModel]? {
        didSet {
            self.tableVie.reloadData()
        }
    }
    
    var didTapAdd: ((String, Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVie.dataSource = self
        tableVie.delegate = self
        self.fetchMedication()
        backBtn.setTitle("", for: .normal)
        self.searchField.becomeFirstResponder()
        self.backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        searchField.addTarget(self, action: #selector(search(_:)), for: .editingChanged)
    }
    
    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func search(_ sender: UITextField) {
        if sender.text == "" {
            self.filteredList = originalList
            return
        }
//        tableVie.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.filteredList = originalList?.filter({($0.brand?.contains(sender.text ?? "") ?? false) || ($0.name?.contains(sender.text ?? "") ?? false)})
    }
    
    func fetchMedication() {
        
        self.showProgressHud()
        NetworkManager.shared.request(BaseMappableModel<MedicationSearchListContainerModel>.self, urlExt: URLConfig.baseUrl + "medicine/active/min", method: .get, param: nil, encoding: JSONEncoding.default, headers: nil) { result in
            self.hideProgressHud()
            switch result {
            case .success(let model):
                self.originalList = model.data?.medicationList
            case .failure(let error):
                self.showAlert(title: nil, message: error.localizedDescription) { _ in
                    
                }
            }
        }
    }

}

extension SearchMedicationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchField.text == "" ? filteredList?.count ?? 0 : ((filteredList?.count ?? 0) + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchField.text != "" && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMedicationAddTableViewCell") as! SearchMedicationAddTableViewCell
            cell.medicationName.text = searchField.text
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMedicationTableViewCell") as! SearchMedicationTableViewCell
        cell.medicationName.text = filteredList?[searchField.text != "" ? (indexPath.row - 1) : indexPath.row].name
        cell.dose.text = filteredList?[searchField.text != "" ? (indexPath.row - 1) : indexPath.row].brand?.components(separatedBy: "-").last ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchMedicationAddTableViewCell {
            self.dismiss(animated: true) {
                self.didTapAdd?(cell.medicationName.text ?? "",0)
            }
            
            return
        }
        self.dismiss(animated: true) {
            let mg = (self.filteredList?[self.searchField.text != "" ? (indexPath.row - 1) : indexPath.row].brand ?? "").components(separatedBy: "-").count == 2 ? (self.filteredList?[self.searchField.text != "" ? (indexPath.row - 1) : indexPath.row].brand ?? "").components(separatedBy: "-").last : ""
            self.didTapAdd?((self.filteredList?[self.searchField.text != "" ? (indexPath.row - 1) : indexPath.row].name ?? ""), (self.filteredList?[self.searchField.text != "" ? (indexPath.row - 1) : indexPath.row].strength ?? 0) )
        }
    }
}
