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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        similarCollection.dataSource = self
        similarCollection.delegate = self
        
        similarCollection.register(UINib(nibName: "SimilarCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SimilarCollectionCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SimilarTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionCell", for: indexPath)
        
        return cell
    }
}
