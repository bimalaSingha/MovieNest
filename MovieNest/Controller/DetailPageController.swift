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
    private var movieDetail: MovieDetail?
    
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
        
//        showLoading(true)
        fetchAllData()
    }
    
    private func showLoading(_ loading: Bool) {
        tableView.isHidden = loading
    }
    
    private func fetchAllData() {
        let group = DispatchGroup()
        let api = MovieAPIService.shared
           
        
        print("movieId is: \(movieId)")
        api.fetchDetail(movieId: movieId) { [weak self] detail in
                DispatchQueue.main.async {
                    self?.movieDetail = detail
                    self?.showLoading(false)
                    self?.tableView.reloadData()
                }
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
            guard let detail = movieDetail else { return cell }
            
            cell.movieLabel.text = detail.title
            cell.genreLabel.text = detail.genres.map { $0.name }.joined(separator: ", ")
            cell.synopsisLabel.text = detail.overview
            cell.ratingsLabel.text = String(format: "%.1f", detail.voteAverage)
            cell.votesLabel.text = "\(detail.voteCount) votes"
            
            
            cell.imageInfo.image = nil  // clear image before reuse
            
            if let path = detail.posterPath,
               let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
                URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                    guard let data = data, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        cell.imageInfo.image = image
                    }
                }.resume()
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableCell", for: indexPath) as! ReviewTableCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableCell", for: indexPath) as! CastTableCell
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarTableCell", for: indexPath) as! SimilarTableCell
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    
}
