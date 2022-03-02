//
//  BloodBankViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 23/02/2022.
//

import UIKit

class BloodBankViewController: UIViewController, Storyboarded {

    var viewModel: BloodBankViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    var models: [BloodBankModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.navigationItem.title = "NearBy Blood Banks"
        self.viewModel.fetchBloodBank()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func bindViewModel() {
        viewModel.bloodBanks.bind { model in
            self.models = model
        }
        viewModel.loading.bind { status in
            if status ?? false {
                self.showProgressHud()
            } else {
                self.hideProgressHud()
            }
        }
        
        viewModel.error.bind { error in
            self.showAlert(title: nil, message: error?.localizedDescription) { _ in
                
            }
        }
    }

}

extension BloodBankViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodBankTableViewCell") as! BloodBankTableViewCell
        cell.index = indexPath.row
        cell.setup()
        cell.model = self.models?[indexPath.row]
        cell.didTapCall = { index in
            let alert = UIAlertController.init(title: "Contact", message: nil, preferredStyle: .actionSheet)
            let numbers = self.models?[index].contactNumber?.components(separatedBy: ",").compactMap({$0.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")})
            numbers?.forEach({ number in
                let action = UIAlertAction.init(title: number, style: .default) { alert in
                    guard let number = URL(string: "tel://" + (alert.title ?? "")) else { return }
                    UIApplication.shared.open(number)
                }
                alert.addAction(action)
            })
            let cancel = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
