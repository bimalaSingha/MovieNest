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
    
    var cast: [CastMemb] = []
    
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
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionCell", for: indexPath) as! CastCollectionCell
        cell.castName.text = cast[indexPath.item].name
        cell.charName.text = cast[indexPath.item].character
        
        if let path = cast[indexPath.item].profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(path)")!
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { cell.castImage.image = UIImage(data: data) }
                }
            }
        }
        return cell
    }
}
