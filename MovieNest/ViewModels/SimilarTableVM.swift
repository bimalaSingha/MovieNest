//
//  SimilarTableVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 27/02/26.
//

import Foundation

class SimilarTableVM {
    private(set) var similarVMs : [SimilarCollectionVM] = []
        
    var count: Int { similarVMs.count }

    func configure(with movies: [Movie]) {
        similarVMs = movies.map { SimilarCollectionVM(movie: $0) }
    }

    func similarVM(at index: Int) -> SimilarCollectionVM {
        return similarVMs[index]
    }
}
