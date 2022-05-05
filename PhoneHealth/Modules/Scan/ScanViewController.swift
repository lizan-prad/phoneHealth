//
//  ScanViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 19/01/2022.
//

import UIKit
import SDWebImage
import PDFKit

class ScanViewController: UIViewController {

    @IBOutlet weak var scannedImage: UIImageView!
    
    @IBOutlet weak var docTitle: UILabel!
    var image: HealthLockerListModel?
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if image?.thumbnails?.components(separatedBy: ".").last == "pdf" {
            setupPdfView()
            self.showProgressHud()
            DispatchQueue.global().async {
                guard let url = URL.init(string: self.image?.thumbnails ?? "") else {return}
                let pdfDOc = PDFDocument.init(url: url)
                
                
                DispatchQueue.main.async {
                    self.pdfView.autoScales = true
                    self.pdfView.document = pdfDOc
                    self.hideProgressHud()
                }
                
            }
        } else {
            self.scannedImage.sd_setImage(with: URL.init(string: image?.thumbnails ?? ""))
        }
        self.docTitle.text = image?.reportTypeName
        shareBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        shareBtn.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.view.bringSubviewToFront(docTitle)
        self.view.bringSubviewToFront(shareBtn)
        self.view.bringSubviewToFront(closeBtn)
    }
    
    func setupPdfView() {
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        self.pdfView = pdfView
        self.pdfView.backgroundColor = .black
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc func shareAction(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: [self.scannedImage.image ?? UIImage()], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            
            if completed  {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
