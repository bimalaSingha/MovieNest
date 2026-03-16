//
//  SearchResultCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 13/03/26.
//

import UIKit
 
class SearchResultCell: UITableViewCell {
 
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
 
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = UIImage(systemName: "film")
        titleLabel.text = nil
    }
 
    func configure(with movie: Movie) {
        // Strip surrounding quotes some TMDB titles contain
        titleLabel.text = movie.title.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
        ImageLoad.loadImage(into: posterImageView, from: movie.posterPath)
    }
}
