//
//  WatchListCollectionViewCell.swift
//  Spotlight
//
//  Created by Keval Shah on 5/3/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class WatchListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var searchImageView: UIImageView!
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
            print(imageToDisplay)
            searchImageView.image = imageToDisplay
        }
        else {
            spinner.startAnimating()
            searchImageView.image = nil
        }
    }
}
