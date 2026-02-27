//
//  DetailViewModel.swift
//  MovieNest
//
//  Created by K Bimala Singha on 26/02/26.
//

import Foundation

class DetailViewModel {

    //the Controller binds to these
    var onDataReady: (() -> Void)?
    var onError: ((String) -> Void)?

    //data
    private(set) var movieDetail: MovieDetail?
    private(set) var reviews: [Review] = []
    private(set) var cast: [CastMemb] = []
    private(set) var similarMovies: [Movie] = []

    //Fetch
    func fetchAllData(for movieId: Int) {
        let group = DispatchGroup()
        let api = MovieAPIService.shared

        group.enter()
        api.fetchDetail(movieId: movieId) { [weak self] detail in
            self?.movieDetail = detail
            group.leave()
        }

        group.enter()
        api.fetchReviews(movieId: movieId) { [weak self] reviews in
            self?.reviews = reviews
            group.leave()
        }

        group.enter()
        api.fetchCredits(movieId: movieId) { [weak self] cast in
            self?.cast = cast
            group.leave()
        }

        group.enter()
        api.fetchSimilar(movieId: movieId) { [weak self] similar in
            self?.similarMovies = similar
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            self?.onDataReady?()
        }
    }
}
