//
//  ViewController.swift
//  MovieNest
//
//  Created by K Bimala Singha on 11/02/26.
//

import UIKit

class MovieListingController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MovieListingViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UISearchBar!
    
    private var viewModel = MovieListingViewModel()
    
    var selectedMovieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self  // for data
        tableView.delegate = self
//        bindViewModel()
        viewModel.delegate = self
        searchView.delegate = self
        viewModel.fetchAllMovies()

    }
    
//  Controller conforms to this protocol
    func didUpdateMovies() {
        tableView.reloadData()
    }
    func didReceiveError(_ message: String) {
        print("Error: \(message)")
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

        let movie = viewModel.cellViewModel(at: indexPath.row)
        cell.configureMovie(with: movie)
        cell.onBookTapped = { [weak self] in
                self?.navigateToDetail(movieId: movie.movieId)
        }
    
        return cell
    }
    
    // search func --- this will fire on every keystroke
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.filterMovies(query: searchText)
//    }
    
    // this will land on searchPage instead of listingPage via segue
    func searchBarShouldBeginEditing(_ searchView: UISearchBar) -> Bool {
        performSegue(withIdentifier: "toSearch", sender: nil)
        return false    // false bcoz it cancels the keyboard opening behaviour on the listing screen
    }
    
    // this will pass the movie list to SearchController before the segue fires
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearch",
           let searchVC = segue.destination as? SearchController {
            searchVC.viewModel.allMovies = viewModel.movies
        }
    }
}


