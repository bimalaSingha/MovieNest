//
//  ReviewTableCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 16/02/26.
//

import UIKit

class ReviewTableCell: UITableViewCell {

    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    var reviews: [Review] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        reviewCollectionView.dataSource = self
        reviewCollectionView.delegate = self
        
        reviewCollectionView.register(UINib(nibName: "ReviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCollectionCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ReviewTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionCell", for: indexPath) as! ReviewCollectionCell
        cell.reviewerName.text = reviews[indexPath.item].author
        cell.commentLabel.text = reviews[indexPath.item].content
        return cell
    }
}
