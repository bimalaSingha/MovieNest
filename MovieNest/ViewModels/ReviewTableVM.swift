//
//  ReviewTableVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 27/02/26.
//

import Foundation

class ReviewTableVM{
    private(set) var reviewVMs: [ReviewCollectionVM] = []

    var count: Int { reviewVMs.count }

    func configure(with reviews: [Review]) {
        reviewVMs = reviews.map { ReviewCollectionVM(review: $0) }
    }

    func reviewVM(at index: Int) -> ReviewCollectionVM {
        return reviewVMs[index]
    }
}
