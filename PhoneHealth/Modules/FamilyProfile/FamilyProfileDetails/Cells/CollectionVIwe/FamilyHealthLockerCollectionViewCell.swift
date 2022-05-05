//
//  FamilyHealthLockerCollectionViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 28/02/2022.
//

import UIKit
import PDFKit

class FamilyHealthLockerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pdfImage: UIImageView!
    @IBOutlet weak var lockerName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var model: HealthLockerListModel? {
        didSet {
            pdfImage.layer.cornerRadius = 4
            pdfImage.image = UIImage.init(named: "pdf")
            if model?.thumbnails?.components(separatedBy: ".").last == "pdf" {
                guard let url = URL.init(string: model?.thumbnails ?? "") else {return}
                DispatchQueue.global().async {
                    let pdfDOc = PDFDocument.init(url: url)
                    let page = pdfDOc?.page(at: 0)
                    DispatchQueue.main.async {
                        let image = page?.thumbnail(of: self.pdfImage.bounds.size, for: .mediaBox)
                        self.pdfImage.image = image
                    }
                }
            } else {
                DispatchQueue.global().async {
                    self.pdfImage.sd_setImage(with: URL.init(string: self.model?.thumbnails ?? ""))
                }
            }
            lockerName.text = model?.reportTypeName
            dateLabel.text = model?.date
        }
    }

}
