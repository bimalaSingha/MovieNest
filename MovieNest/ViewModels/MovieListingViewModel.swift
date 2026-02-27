//
//  MovieListingVM.swift
//  MovieNest
//
//  Created by K Bimala Singha on 23/02/26.
//

import Foundation

class MovieListingViewModel {
    // data source   //  ensuring that vc can read the movies data but cannot change them
    private(set) var movies: [Movie] = []

    // Callbacks (tthe view binds to these)
    var onMoviesUpdated: (() -> Void)?  // as viewmodel is not allowed to talk to the tableView directly, we needs a way to say that it has the movie data, when this is called tableView.reloadData() is run
    var onError: ((String) -> Void)?  // if something goes wrong because of wrong api key/ poor connection, the viewmodel knows first. then it informs vc.

    // below will Fetch and Refresh the data
//    var movies: [Movie] = []     // the data source
    
    func fetchAllMovies(query: String? = nil) {

        let urlString = Constants.baseURL + Constants.nowPlaying + "?api_key=" + Constants.apiKey
        print("Listing URL: \(urlString)")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    self.movies = response.results // data source update
                    self.onMoviesUpdated?()   // reload ui
                }
            } catch {
                print("Decoding error: \(error)")
                self.onError?("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
