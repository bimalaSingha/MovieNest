//
//  SimilarCollectionVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 27/02/26.
//

import Foundation

class SimilarCollectionVM{
    private let movie: Movie

    var title: String { movie.title }
    var posterPath: String? { movie.posterPath }
    var movieId: Int { movie.id }

    init(movie: Movie) {
        self.movie = movie
    }
}
