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
    
//    var cast: [CastMemb] = []
    
//    private var castTableVM : [CastMemb] = []
    private var castTableVM : CastTableVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castCollection.dataSource = self
        castCollection.delegate = self
        
        castCollection.register(UINib(nibName: "CastCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionCell")
        
    }
    
    /// this func is called from the controller instead of setting cast and calling reloadData manually.
//    func configureCast(with cast: [CastMemb]) {
//        self.cast = cast
//        castCollection.reloadData()
//    }
    
    func configure(with vm: CastTableVM) {
        castTableVM = vm
        castCollection.reloadData()
    }
    
}

extension CastTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cast.count
        return castTableVM?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionCell", for: indexPath) as! CastCollectionCell
        
//        cell.configureCast(with: cast[indexPath.item])
//        
//        let castMember = cast[indexPath.item]
//        let vm = CastCollectionVM(cast: castMember)
//        cell.configureCast(with: vm)
        
        if let vm = castTableVM?.castVM(at: indexPath.item) {
            cell.configureCast(with: vm)
        }
        
        return cell
    }
}
