//
//  ImageLoad.swift
//  MovieNest
//
//  Created by K Bimala Singha on 26/02/26.
//

import UIKit

class ImageLoad {
    
    static func loadImage(into imageView: UIImageView, from path: String?) {   //using static so that I call it without creating an instance of the class
        
        imageView.image = UIImage(named: "placeholder")
        
        guard let path = path, !path.isEmpty else { return }
        let imageString = Constants.imageBase + path
        guard let url = URL(string: imageString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
}

