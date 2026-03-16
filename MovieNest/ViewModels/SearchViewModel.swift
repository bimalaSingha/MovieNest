//
//  SearchViewModel.swift
//  MovieNest
//
//  Created by K Bimala Singha on 11/03/26.
//

import Foundation


protocol SearchViewModelDelegate: AnyObject {
    func didUpdateMovies()
}

class SearchViewModel{
    
    weak var delegate: SearchViewModelDelegate?
    
    var allMovies: [Movie] = []   // full movie list
    private(set) var movies: [Movie] = [] // list shown in the table (search results/recent searches)

    private(set) var isShowingRecents: Bool = true   // whether we're in "recent searches" mode (empty query) or "results" mode
    private let maxRecents = 10

    /// ids of recently selected movies
    private var recentIDs: [Int] = []
    
    /// movie objects that match the stored recent IDs (in recency order).
    var recentMovies: [Movie] {
        return recentIDs.compactMap { id in allMovies.first { $0.id == id } }
    }

    /// Call this whenever the search bar text changes.
    func filterMovies(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            // show recent searches
            isShowingRecents = true
            movies = recentMovies
        } else {
            // show filtered results
            isShowingRecents = false
            movies = allMovies.filter {
                $0.title.localizedCaseInsensitiveContains(trimmed)
            }
        }
        delegate?.didUpdateMovies()
    }

    /// Call this when tapped a movie so we persist it as a recent search.
    func saveRecentSearch(movieId: Int) {
        var ids = recentIDs
        ids.removeAll { $0 == movieId }   // this will avoid duplicates
        if ids.count > maxRecents { ids = Array(ids.prefix(maxRecents)) }
        recentIDs = ids
    }
    
}
