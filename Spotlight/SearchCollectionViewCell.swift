//
//  SearchCollectionViewCell.swift
//  Spotlight
//
//  Created by Keval Shah on 5/2/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
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
            searchImageView.image = imageToDisplay
        }
        else {
            spinner.startAnimating()
            searchImageView.image = nil
        }
    }
}
