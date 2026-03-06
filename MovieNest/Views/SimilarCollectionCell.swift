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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        similarImage.image = nil
    }

//    func configureSimilar(with vm: Movie) {
    func configureSimilar(with vm: SimilarCollectionVM) {
        similarMovie.text = vm.title
        ImageLoad.loadImage(into: similarImage, from: vm.posterPath)
    }
}
