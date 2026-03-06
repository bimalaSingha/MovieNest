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
   
    private var rowsVisible: [Int] {
        var rows: [Int] = [0,2]
        // if movie synopsis is present then cast will always be there.
//        rows.append(0)
        
        if viewModel.reviewTableVM.count > 0 { rows.insert(1, at: 1) } /// here append(1) will lofically fail as array would look like this: [0,2,1] and reviews section will go to the 3rd section
        
//        if viewModel.reviewTableVM.count > 0 { rows.append(1) }
//        rows.append(2)
        if viewModel.similarTableVM.count > 0 { rows.append(3) }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4 // Row 0 for Info, Row 1 for Reviews
        return rowsVisible.count
    }
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rowsVisible[indexPath.row]
        switch row {
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
            cell.configure(with: viewModel.reviewTableVM)

            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableCell", for: indexPath) as! CastTableCell
//            cell.configureCast(with: viewModel.cast)
            cell.configure(with: viewModel.castTableVM)

            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarTableCell", for: indexPath) as! SimilarTableCell
            cell.configure(with: viewModel.similarTableVM)

            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
