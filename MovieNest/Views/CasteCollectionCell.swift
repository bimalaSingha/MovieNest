//
//  CastCollectionCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 16/02/26.
//

import UIKit

class CastCollectionCell: UICollectionViewCell {

    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var charName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        castImage.image = nil
    }
    
//    func configureCast(with cast: CastMemb){
//        castName.text = cast.name
//        charName.text = cast.character
//        
//        ImageLoad.loadImage(into: castImage, from: cast.profilePath)
//    }
    
    func configureCast(with vm: CastCollectionVM){
        castName.text = vm.name
        charName.text = vm.character
        ImageLoad.loadImage(into: castImage, from: vm.profilePath)
    }
}
