//
//  MovieCollectionViewCell.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/23/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateWithImage(nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateWithImage(nil)
    }
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        }
        else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
