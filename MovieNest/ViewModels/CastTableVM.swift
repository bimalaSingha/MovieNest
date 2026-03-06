//
//  CastTableVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 27/02/26.
//

import Foundation

class CastTableVM{
    
    private(set) var castVMs: [CastCollectionVM] = []

    var count: Int { castVMs.count }

    func configure(with cast: [CastMemb]) {
        castVMs = cast.map { CastCollectionVM(cast: $0) }
    }

    func castVM(at index: Int) -> CastCollectionVM {
        return castVMs[index]
    }
}
