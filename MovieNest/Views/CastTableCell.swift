//
//  CastTableCell.swift
//  MovieNest
//
//  Created by K Bimala Singha on 16/02/26.
//

import UIKit

class CastTableCell: UITableViewCell {

    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castCollection.dataSource = self
        castCollection.delegate = self
        
        castCollection.register(UINib(nibName: "CastCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CastTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionCell", for: indexPath)
        
        return cell
    }
}
