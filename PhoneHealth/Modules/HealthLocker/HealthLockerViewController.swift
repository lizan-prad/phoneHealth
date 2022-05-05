//
//  HealthLockerViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 11/02/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import WeScan
import Alamofire
import PDFKit


class HealthLockerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var uploadedImage: UIView!
    @IBOutlet weak var uploadContainer: UIView!
    @IBOutlet weak var selectDocBtn: UIButton!
    @IBOutlet weak var reportTypeField: MDCOutlinedTextField!
    @IBOutlet weak var reportDateField: MDCOutlinedTextField!
    @IBOutlet weak var hospitalNameField: MDCOutlinedTextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
//    @IBOutlet weak var scannedImageView: UIImageView!
    
    var reports: [DynamicUserDataModel]? {
        didSet {
            self.reportPicker.reloadAllComponents()
        }
    }
    
    var images = [UIImage]() {
        didSet {
            self.collectionView.reloadData()
            self.uploadContainer.isHidden = images.count != 0
        }
    }
    
    var selectedReport: DynamicUserDataModel? {
        didSet {
            self.reportTypeField.text = selectedReport?.label
        }
    }
    
    var callForRefresh: (() -> ())?
    
    let reportPicker = UIPickerView()
    var viewModel: HealthLockerViewModel!
    let picker = UIDatePicker()
    var selectedDate: String?
    
    var isFamily = false
    var familyId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.isFamily = isFamily
        setup()
        bindViewModel()
//        self.uploadedImage.isHidden = true
//        self.scannedImageView.layer.cornerRadius = 12
        self.viewModel.getReportTypeDropDown()
        self.selectDocBtn.setAttributedTitle("Select Document".getAtrribTextwith(10), for: .normal)
        self.closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        self.selectDocBtn.addTarget(self, action: #selector(selectDocAction), for: .touchUpInside)
//        self.scannedImageView.isUserInteractionEnabled = true
//        self.scannedImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addMultiple)))
    }
    
    @objc func addMultiple() {
        self.showAlert(title: nil, message: "Add more images?") { _ in
            self.selectAdditionalDocAction()
        }
    }
    
    func bindViewModel() {
        self.viewModel.reportType.bind { model in
            self.reports = model
        }
        self.viewModel.success.bind { model in
            self.dismiss(animated: true) {
                self.callForRefresh?()
            }
        }
        self.viewModel.loading.bind { status in
            if status ?? false { self.showProgressHud() } else {self.hideProgressHud()}
        }
    }
    
    func selectAdditionalDocAction() {
        let imageManager = ImagePickerManager()
        imageManager.userCustomCamera = true
        imageManager.didRequestCustomCamera = {
            let scannerViewController = ImageScannerController()
            scannerViewController.imageScannerDelegate = self
            scannerViewController.modalPresentationStyle = .overFullScreen
            self.present(scannerViewController, animated: true)
        }
        imageManager.pickImage(self){ image in
            self.uploadContainer.isHidden = true
            self.images.append(image)
//            self.uploadedImage.isHidden = false
//            self.scannedImageView.image = image
//            self.images.append(image)
        }
    }
    
    
    @objc func selectDocAction() {
        let imageManager = ImagePickerManager()
        imageManager.userCustomCamera = true
        imageManager.didRequestCustomCamera = {
            let scannerViewController = ImageScannerController()
            scannerViewController.imageScannerDelegate = self
            scannerViewController.modalPresentationStyle = .overFullScreen
            self.present(scannerViewController, animated: true)
        }
        imageManager.pickImage(self){ image in
            self.uploadContainer.isHidden = true
//            self.uploadedImage.isHidden = false
//            self.scannedImageView.image = image
            self.images.append(image)
        }
    }
    
    @objc func saveAction() {
        let imageKey = "\(images.count == 1 ? "IMG_" : "Doc_")\(Int(Date().timeIntervalSince1970)).\(images.count == 1 ? "jpeg" : "pdf")"
        
        let pdf = images.makePDF()
        let param = ["fileName": URLConfig.minioBase + "\(UserDefaults.standard.value(forKey: "Mobile") as? String ?? "")\(isFamily ? "/user-family" : "")/healthLocker/\(imageKey)"]
        MinioManager.shared.requestMinioUrl(param: param, encoding: JSONEncoding.default, headers: nil) { result in
            switch result {
            case .success(let url):
                if let url = URL.init(string: url) {
                    
                    var request = URLRequest.init(url: url)
                    request.method = .put
                    request.headers = ["Content-Type": "\(self.images.count == 1 ? "image/jpeg" : "application/document" )"]
//                    var data = Data("Content-Disposition: form-data".utf8)
//                    data += Data("Content-Type: octet-stream\r\n\r\n".utf8)
                    guard let body = (self.images.count == 1) ? self.images.first?.jpegData(compressionQuality: 0.2) : pdf?.dataRepresentation() else {return}//self.scannedImageView.image?.pngData() else { return }
                    request.httpBody = body
                    AF.request(request).response { response in
                        self.viewModel.addHealthLocker(fileUri: param["fileName"]!, fileType: "\(self.images.count == 1 ? "image/jpeg" : "application/document" )", fileSize: body.count, hospitalName: self.hospitalNameField.text ?? "", name: self.selectedReport?.label ?? "", reportDate: self.selectedDate ?? "", reportId: self.selectedReport?.value ?? 0, userId: self.isFamily ? "\(self.familyId ?? 0)" : nil)
                    }
//                    MinioManager.shared.upload(image: [(self.scannedImageView.image?.pngData() ?? Data()).base64EncodedData()], to: request, params: [String:Any]())
                }
            case .failure( _):
                break
            }
            
        }
    }
    
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        reportTypeField.inputView = reportPicker
        reportPicker.dataSource = self
        reportPicker.delegate = self
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
            }
        } else {
            // Fallback on earlier versions
        }
        picker.addTarget(self, action: #selector(didSelectData(_:)), for: .valueChanged)
        
        reportDateField.inputView = picker
        
        reportTypeField.setup("Report Type")
        reportDateField.setup("Report Date")
        hospitalNameField.setup("Hospital Name")
        containerView.layer.cornerRadius = 22
        saveBtn.layer.cornerRadius = 12
        selectDocBtn.layer.cornerRadius = 4
        closeBtn.setTitle("", for: .normal)
        
//        let scannerViewController = ImageScannerController()
//        scannerViewController.imageScannerDelegate = self
//        present(scannerViewController, animated: true)
    }
    
    @objc func didSelectData(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd eee"
        self.reportDateField.text = formatter.string(from: sender.date)
        formatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.sssZ"
        self.selectedDate = formatter.string(from: sender.date)
    }


}

extension HealthLockerViewController: ImageScannerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count == 0 ? 0 : images.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HealthLockerAddCollectionViewCell", for: indexPath) as! HealthLockerAddCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HealthLockerImageCollectionViewCell", for: indexPath) as! HealthLockerImageCollectionViewCell
        cell.setup()
        cell.didTapClose = { index in
            self.images.remove(at: index)
        }
        cell.index = indexPath.row - 1
        cell.image = self.images[indexPath.row - 1]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.selectDocAction()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 90, height: 90)
    }
    
    
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        scanner.dismiss(animated: true) {
            self.uploadContainer.isHidden = true
//            self.uploadedImage.isHidden = false
//            self.scannedImageView.image = results.enhancedScan?.image
            self.images.append(results.croppedScan.image)
        }
        
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        
    }
}

extension HealthLockerViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.reports?.count ?? 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reports?[row].label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedReport = reports?[row]
    }
}

extension Array where Element: UIImage {
    
      func makePDF()-> PDFDocument? {
        let pdfDocument = PDFDocument()
        for (index,image) in self.enumerated() {
            let pdfPage = PDFPage(image: image)
            pdfDocument.insert(pdfPage!, at: index)
        }
        return pdfDocument
    }
}
