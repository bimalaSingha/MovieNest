//
//  ReviewCollectionVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 27/02/26.
//

import Foundation

class ReviewCollectionVM{
    private let review: Review

    var author: String { review.author }
    var content: String { review.content }

    init(review: Review) {
        self.review = review
    }
}
