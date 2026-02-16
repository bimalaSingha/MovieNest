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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self  // for data
        tableView.delegate = self
        
        fetchAllMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    // display movie information
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",  for: indexPath) as! MovieCell
        
        //    since TMDB won't give a full image URL, we have to build the full URL yourself.
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.releaseDate.text = movie.releaseDate
        cell.descriptionLabel.text = movie.overview
        
        // reset image
        cell.movieImageView.image = UIImage(named: "placeholder")
        
        if let path = movie.posterPath {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(path)")!
            
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
    
    
    // below will Fetch and Refresh the data
    var movies: [Movie] = []     // the data source
    
    func fetchAllMovies(query: String? = nil) {

        let urlString = Constants().baseURL + Constants().nowPlaying + "?api_key=" + Constants().apiKey
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("error fetching data: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    // Update data source and reload the UI
                    self.movies = response.results
                    self.tableView.reloadData()
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }

    
}


