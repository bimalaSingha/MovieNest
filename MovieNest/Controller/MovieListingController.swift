//
//  ViewController.swift
//  MovieNest
//
//  Created by K Bimala Singha on 11/02/26.
//

import UIKit

class MovieListingController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UISearchBar!
    
    private var viewModel = MovieListingViewModel()
    
    var selectedMovieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self  // for data
        tableView.delegate = self
        bindViewModel()
        
        viewModel.fetchAllMovies()

    }
    
   // binding part      when the viewmodel gets new data
    func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { message in
            print("Error: \(message)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func navigateToDetail(movieId: Int) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageController") as? DetailPageController
        else { return }
        detailVC.movieId = movieId
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // display movie information
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",  for: indexPath) as! MovieCell
        
        //    since TMDB won't give a full image URL, we have to build the full URL yourself.
        let movie = viewModel.cellViewModel(at: indexPath.row)
        cell.configureMovie(with: movie)
        
//        ImageLoad.loadImage(into: cell.movieImageView, from: movie.posterPath)
        cell.onBookTapped = { [weak self] in        // ← add this
                self?.navigateToDetail(movieId: movie.movieId)
        }
    
        return cell
    }
    
}


