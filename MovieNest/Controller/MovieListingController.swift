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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    } /// hides the nav bar for the entire navigation controller, so we need to unhide in the next page for back button.
//
    
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        print("tapped movie: \(movie.title), id: \(movie.id)")
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageController") as! DetailPageController
        detailVC.movieId = movie.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // display movie information
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",  for: indexPath) as! MovieCell
        
        //    since TMDB won't give a full image URL, we have to build the full URL yourself.
        let movie = viewModel.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.releaseDate.text = movie.releaseDate
        cell.descriptionLabel.text = movie.overview
        cell.bookButton.isUserInteractionEnabled = false
        
        // reset image
        cell.movieImageView.image = UIImage(named: "placeholder")
        
        if let path = movie.posterPath {
            
            let imageString = Constants.imageBase + path
            guard let imageUrl = URL(string: imageString) else { return cell }

            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        // this sets the image only if the cell is showing the movie
                        if let updateCell = tableView.cellForRow(at: indexPath) as? MovieCell {
                            updateCell.movieImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        return cell
    }
    
}


