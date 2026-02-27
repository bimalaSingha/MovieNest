//
//  DetailPageController.swift
//  MovieNest
//
//  Created by K Bimala Singha on 13/02/26.
//

import UIKit

class DetailPageController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
   
    var movieId: Int = 0
    private var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 220
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            UINib(nibName: "InfoTableCell", bundle: nil), forCellReuseIdentifier: "InfoTableCell");
        tableView.register(
            UINib(nibName: "ReviewTableCell", bundle: nil), forCellReuseIdentifier: "ReviewTableCell");
        tableView.register(
            UINib(nibName: "CastTableCell", bundle: nil), forCellReuseIdentifier: "CastTableCell");
        tableView.register(
            UINib(nibName: "SimilarTableCell", bundle: nil), forCellReuseIdentifier: "SimilarTableCell");
        
        bindViewModel()
        viewModel.fetchAllData(for: movieId)
    }
    
    func bindViewModel() {
        viewModel.onDataReady = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { message in
            print("Detail error: \(message)")
        }
    }
}


extension DetailPageController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // Row 0 for Info, Row 1 for Reviews
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableCell", for: indexPath) as! InfoTableCell
            guard let detail = viewModel.movieDetail else {return cell }
            
            cell.movieLabel.text = detail.title
            cell.genreLabel.text = detail.genres.map { $0.name }.joined(separator: ", ")
            cell.synopsisLabel.text = detail.overview
            cell.ratingsLabel.text = String(format: "%.1f ratings", detail.voteAverage)
            cell.votesLabel.text = "\(detail.voteCount) votes"
            
            cell.imageInfo.image = nil  // clear image before reuse
            
            ImageLoad.loadImage(into: cell.imageInfo, from: detail.posterPath)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableCell", for: indexPath) as! ReviewTableCell
            cell.configureReview(with: viewModel.reviews)
//            cell.reviews = reviews
//            cell.reviewCollectionView.reloadData()
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableCell", for: indexPath) as! CastTableCell
            cell.configureCast(with: viewModel.cast)
//            cell.cast = cast
//            cell.castCollection.reloadData()
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarTableCell", for: indexPath) as! SimilarTableCell
            cell.configureSimilar(with: viewModel.similarMovies)
//            cell.similarMovies = similarMovies
//            cell.similarCollection.reloadData()
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
