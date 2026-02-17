//
//  DetailPageController.swift
//  MovieNest
//
//  Created by K Bimala Singha on 13/02/26.
//

import UIKit

class DetailPageController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieData: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 200  
        
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
