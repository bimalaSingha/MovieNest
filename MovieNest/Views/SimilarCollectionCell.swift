//
//  SimilarCollectionCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 16/02/26.
//

import UIKit

class SimilarCollectionCell: UICollectionViewCell {

    @IBOutlet weak var similarImage: UIImageView!
    @IBOutlet weak var similarMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        similarImage.layer.cornerRadius = 10
    }

}
