//
//  ReviewCollectionCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 16/02/26.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {

    @IBOutlet weak var reviewView: UIView!   /// had to connect for cornerRadius
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewView.layer.cornerRadius = 10
    }

}
