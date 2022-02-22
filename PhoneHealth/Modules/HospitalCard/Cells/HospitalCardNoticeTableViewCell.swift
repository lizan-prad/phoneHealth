//
//  HospitalCardNoticeTableViewCell.swift
//  PhoneHealth
//
//  Created by Lizan on 12/02/2022.
//

import UIKit

class HospitalCardNoticeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var noticeTitle: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var noticeCOnatiner: UIView!
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    var notices: [HospitalNoticeModel]? {
        didSet {
            self.pageControl.numberOfPages = notices?.count ?? 0
            self.collectionView.reloadData()
        }
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "HospitalNoticeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HospitalNoticeCollectionViewCell")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        if let ip = collectionView.indexPathForItem(at: center) {
            self.noticeTitle.text = self.notices?[ip.row].title
            self.pageControl.currentPage = ip.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notices?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HospitalNoticeCollectionViewCell", for: indexPath) as! HospitalNoticeCollectionViewCell
        cell.descLabel.text = notices?[indexPath.row].description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    
}
