//
//  SearchController.swift
//  MovieNest
//
//  Created by K Bimala Singha on 11/03/26.
//
//
import UIKit

class SearchController: UIViewController, UISearchBarDelegate, SearchViewModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchLabel: UILabel!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.rowHeight = 60

        searchTableView.dataSource = self
        searchTableView.delegate   = self
        viewModel.delegate  = self
        searchBar.delegate  = self

        // show recent searches (or empty state) right away
        viewModel.filterMovies(query: "")
    }
    
    func didUpdateMovies() {
        searchTableView.reloadData()
    }
    func didReceiveError(_ message: String) {
        print("Error: \(message)")
    }

    // search func -- this will fire on every keystroke
    // search delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(query: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // tableedatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    // tableDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movies[indexPath.row]
        viewModel.saveRecentSearch(movieId: movie.id)   // persist to recent searches
        
        // this is to navigate to Detail page
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageController") as? DetailPageController
        else { return }
        detailVC.movieId = movie.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
