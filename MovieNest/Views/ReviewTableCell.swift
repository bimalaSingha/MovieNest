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
    
//    var reviews: [Review] = []
    private var reviewTableVM : ReviewTableVM?
    
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
    
    func configure(with vm: ReviewTableVM) {
        reviewTableVM = vm
        reviewCollectionView.reloadData()
    }
}

extension ReviewTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return reviews.count
        return reviewTableVM?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionCell", for: indexPath) as! ReviewCollectionCell
        
//        cell.configureReview(with: reviews[indexPath.item])
        
//        let review = reviews[indexPath.item]
//        let vm = ReviewCollectionVM(review: review)
//        cell.configureReview(with: vm)
        
        if let vm = reviewTableVM?.reviewVM(at: indexPath.item){
            cell.configureReview(with: vm)
        }
        return cell
    }
}
