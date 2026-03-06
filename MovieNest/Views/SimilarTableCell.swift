//
//  SimilarTableCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 16/02/26.
//

import UIKit

class SimilarTableCell: UITableViewCell {

    @IBOutlet weak var similarLabel: UILabel!
    @IBOutlet weak var similarCollection: UICollectionView!
    
    
//    var similarMovies: [Movie] = []
    
    private var similarTableVM: SimilarTableVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        similarCollection.dataSource = self
        similarCollection.delegate = self
        
        similarCollection.register(UINib(nibName: "SimilarCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SimilarCollectionCell")
        
    }
    
//    func configureSimilar(with movies: [Movie]) {
//        self.similarMovies = movies
//        similarCollection.reloadData()
//    }
    
    func configure(with vm: SimilarTableVM) {
        similarTableVM = vm
        similarCollection.reloadData()
    }
    
}

extension SimilarTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarTableVM?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionCell", for: indexPath) as! SimilarCollectionCell
//        cell.configureSimilar(with: similarMovies[indexPath.item])
        if let vm = similarTableVM?.similarVM(at: indexPath.item) {
            cell.configureSimilar(with: vm)
        }
        
        return cell
    }
}
