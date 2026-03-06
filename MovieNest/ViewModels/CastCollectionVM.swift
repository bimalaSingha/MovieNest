//
//  CastCollectionVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 27/02/26.
//

import Foundation

class CastCollectionVM {
    private let cast: CastMemb

    var name: String { cast.name }
    var character: String { cast.character }
    var profilePath: String? { cast.profilePath }

    init(cast: CastMemb) {
        self.cast = cast
    }
}
