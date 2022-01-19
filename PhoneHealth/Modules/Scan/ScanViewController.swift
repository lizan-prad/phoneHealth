//
//  ScanViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 19/01/2022.
//

import UIKit

class ScanViewController: UIViewController {

    @IBOutlet weak var scannedImage: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scannedImage.image = image
        // Do any additional setup after loading the view.
    }

}
