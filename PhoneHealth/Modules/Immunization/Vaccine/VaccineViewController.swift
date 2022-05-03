//
//  VaccineViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 20/03/2022.
//

import UIKit

enum VaccineViewType {
    case present
    case history
}

class VaccineViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: VaccineViewModel!
    
    var currentVaccineType: VaccineViewType?
    
    var model: [AvailableVaccineList]?
    
    var childId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.childId = viewModel.childModel?.id
        tableView.dataSource = self
        tableView.delegate = self
        
        if currentVaccineType == .history {
            self.viewModel.fetchVaccinationHistoryList(id: self.childId ?? 0)
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        tableView.register(UINib.init(nibName: "VaccinesTableViewCell", bundle: nil), forCellReuseIdentifier: "VaccinesTableViewCell")
        
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
        
        viewModel.history.bind { models in
        
            self.model = models?.map({ m in
                var mo = AvailableVaccineList()
                mo.title = m.title
                mo.availableVaccinesList = m.availableVaccinesList
                return mo
            })
            self.tableView.reloadData()
        }
        
        viewModel.success.bind { msg in
            self.showAlert(title: nil, message: msg) { _ in
                NotificationCenter.default.post(name: Notification.Name.init("IMMUNIZATION_DONE"), object: nil)
            }
        }
        
        viewModel.loading.bind { status in
            status ?? false ? self.showProgressHud() : self.hideProgressHud()
        }
    }
    
    
 
}

extension VaccineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VaccinesTableViewCell") as! VaccinesTableViewCell
        cell.setup()
        cell.vaccinationViewType = self.currentVaccineType
        cell.model = self.model?[indexPath.section]
        cell.didTapTake = { model in
            let vc = UIStoryboard.init(name: "TakeVaccine", bundle: nil).instantiateViewController(withIdentifier: "TakeVaccineViewController") as! TakeVaccineViewController
            vc.model = model
            vc.didFinishedTaking = { model,vaccine in
                self.viewModel.takeAction(model: model, vaccine: vaccine, id: self.childId ?? 0)
            }
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(((model?[indexPath.section].availableVaccinesList?.count ?? 0)*30) + 92)
    }
}
