//
//  MovieListingVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 23/02/26.
//

import Foundation

protocol MovieListingViewModelDelegate: AnyObject {
    func didUpdateMovies()
    func didReceiveError(_ message: String)
}

class MovieListingViewModel {
    
    weak var delegate: MovieListingViewModelDelegate?
    // data source   //  ensuring that vc can read the movies data but cannot change them
    private(set) var movies: [Movie] = []  // The list shown in the TableView
    private var allMovies: [Movie] = [] // The unfiltered list for search
    
    // Callbacks (tthe view binds to these)
    //    var onMoviesUpdated: (() -> Void)?  // as viewmodel is not allowed to talk to the tableView directly, we needs a way to say that it has the movie data, when this is called tableView.reloadData() is run
    //    var onError: ((String) -> Void)?  // if something goes wrong because of wrong api key/ poor connection, the viewmodel knows first. then it informs vc.
    
    //Computed properties - cell config
    func cellViewModel(at index: Int) -> MovieCellViewModel {
        return MovieCellViewModel(movie: movies[index])
    }
    
    // below will Fetch and Refresh the data
//    var movies: [Movie] = []     // the data source
    
    func fetchAllMovies(query: String? = nil) {
        //    func fetchAllMovies() {
        
        let urlString = Constants.baseURL + Constants.nowPlaying + "?api_key=" + Constants.apiKey
        print("Listing URL: \(urlString)")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in  // added [weak self] to prevent memory leak
            if let error = error {
                DispatchQueue.main.async {
                    //                    self?.onError?(error.localizedDescription)
                    self?.delegate?.didReceiveError(error.localizedDescription)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.movies = response.results // data source update
                    self?.delegate?.didUpdateMovies()
                    self?.allMovies = response.results  // store unfiltered source for search
                }
            } catch {
                print("Decoding error: \(error)")
                //                self?.onError?("Decoding error: \(error.localizedDescription)")
                    self?.delegate?.didReceiveError("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // Search        this filter will compare the query against allMovies(the original movie list)
//    func filterMovies(query: String) {
//        if query.trimmingCharacters(in: .whitespaces).isEmpty {
//            movies = allMovies   // this is for, if the user types an empty string then it will show the original movie list
//        } else {
//            movies = allMovies.filter {
//                $0.title.localizedCaseInsensitiveContains(query)
//            }
//        }
//        delegate?.didUpdateMovies()     // reload
//    }
}



//// this is for the table cell in Listing page

class MovieCellViewModel {
    private let movie: Movie

    var title: String       { movie.title }
    var releaseDate: String? { movie.releaseDate }
    var overview: String    { movie.overview }
    var posterPath: String? { movie.posterPath }
    var movieId: Int        { movie.id }

    init(movie: Movie) {
        self.movie = movie
    }
}
