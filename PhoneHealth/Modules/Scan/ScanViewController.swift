//
//  ScanViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 19/01/2022.
//

import UIKit
import SDWebImage

class ScanViewController: UIViewController {

    @IBOutlet weak var scannedImage: UIImageView!
    
    @IBOutlet weak var docTitle: UILabel!
    var image: HealthLockerListModel?
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scannedImage.sd_setImage(with: URL.init(string: image?.thumbnails ?? ""))
        self.docTitle.text = image?.reportTypeName
        shareBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        shareBtn.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
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
