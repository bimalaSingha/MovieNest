//
//  MovieCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 13/02/26.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var onBookTapped: (() -> Void)?
    
    @IBAction func bookButton(_ sender: UIButton) {
        onBookTapped?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           onBookTapped = nil
    }
    
    func configureMovie(with viewModel: MovieCellViewModel){
        
        movieImageView.image = UIImage(named: "placeholder")
        titleLabel.text = viewModel.title
        releaseDate.text = viewModel.releaseDate
        descriptionLabel.text = viewModel.overview
        ImageLoad.loadImage(into: movieImageView, from: viewModel.posterPath)
    }

}
